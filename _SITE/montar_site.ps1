$ErrorActionPreference = 'Stop'
$raiz = "C:\Users\Pichau\Desktop\GAMES AIRSOFT\GADGETS"
$scratch = Split-Path $PSCommandPath
$site = Join-Path $scratch "site"
if (Test-Path $site) { Get-ChildItem $site -Recurse -File | ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force -Confirm:$false } }
New-Item -ItemType Directory -Force $site | Out-Null
$utf8 = New-Object Text.UTF8Encoding $false
$copiados = @{}

function Copiar($origem, $relativo) {
  $destino = Join-Path $site $relativo
  New-Item -ItemType Directory -Force (Split-Path $destino) | Out-Null
  Copy-Item -LiteralPath $origem $destino -Force
  $script:copiados[$relativo.Replace('\', '/')] = $true
}

$paginas = Get-ChildItem $raiz -Recurse -File -Filter *.html | Where-Object { $_.FullName -notmatch '\\(stl|img)\\' }
foreach ($pag in $paginas) {
  $rel = $pag.FullName.Substring($raiz.Length + 1)
  $texto = [IO.File]::ReadAllText($pag.FullName, [Text.Encoding]::UTF8)
  if ($texto.Length -lt 500) { throw "leitura curta: $rel" }
  $nivel = ($rel.Split('\').Count - 1)
  $volta = ('../' * $nivel) + 'INICIO.html'
  $botao = "<a href=""$volta"" style=""position:fixed;z-index:50;right:calc(12px + env(safe-area-inset-right,0px));bottom:calc(12px + env(safe-area-inset-bottom,0px));background:#161a1d;color:#9cc35a;border:1px solid #9cc35a;border-radius:8px;padding:8px 12px;font:600 13px 'Segoe UI',system-ui,sans-serif;text-decoration:none;box-shadow:0 2px 10px rgba(0,0,0,.4)"">&#9666; Gadgets BLACK BIRD</a>"
  $m = [regex]::Match($texto, '<body[^>]*>')
  if (-not $m.Success) { throw "sem <body>: $rel" }
  $texto = $texto.Insert($m.Index + $m.Length, "`n" + $botao)
  $destino = Join-Path $site $rel
  New-Item -ItemType Directory -Force (Split-Path $destino) | Out-Null
  [IO.File]::WriteAllText($destino, $texto, $utf8)
  $copiados[$rel.Replace('\', '/')] = $true
  # arquivos que a página usa (imagens, scripts, textos), fora STL e código
  foreach ($r in [regex]::Matches($texto, '(?:src|href)="([^"#?:]+)"')) {
    $alvo = $r.Groups[1].Value
    if ($alvo -match '\.(html|stl|ino)$') { continue }
    $abs = [IO.Path]::GetFullPath((Join-Path $pag.DirectoryName ($alvo.Replace('/', '\'))))
    if (-not $abs.StartsWith($raiz) -or -not (Test-Path -LiteralPath $abs -PathType Leaf)) { continue }
    Copiar $abs ($abs.Substring($raiz.Length + 1))
  }
}
# página inicial: também como INICIO.html (o botão das prévias volta para ela)
$hub = [IO.File]::ReadAllText((Join-Path $scratch "site_hub.html"), [Text.Encoding]::UTF8)
[IO.File]::WriteAllText((Join-Path $site "INICIO.html"), "<!doctype html>`n<html lang=""pt-BR"">`n<head>`n<meta charset=""utf-8"">`n<meta name=""viewport"" content=""width=device-width,initial-scale=1,viewport-fit=cover"">`n" + $hub + "`n</html>", $utf8)
foreach ($i in [regex]::Matches($hub, 'src="([^"]+\.png)"')) {
  $abs = Join-Path $raiz ($i.Groups[1].Value.Replace('/', '\'))
  if (Test-Path -LiteralPath $abs) { Copiar $abs $i.Groups[1].Value }
}
$todos = Get-ChildItem $site -Recurse -File
"{0} arquivos, {1:N1} MB" -f $todos.Count, (($todos | Measure-Object Length -Sum).Sum / 1MB)
$todos | Where-Object { $_.Extension -notin '.png', '.html' } | ForEach-Object { $_.FullName.Substring($site.Length + 1) }
