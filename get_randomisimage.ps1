if ($IsMacOS){ $srcdir = "/path/to/where/you/keep/images" } else { $srcdir = "\path\to\where\you\keep\images" }

# the src dir should be customized to map to where you have the parent folder of any concept art / stored images for inspiration.

$includes = @("*.jpg","*.png","*.jpeg","*.gif","*.webp")

# assign a variable to every subfolder name.

$lands     = Get-ChildItem -Include $includes $srcdir\is_lands\*
$maps      = Get-ChildItem -Include $includes $srcdir\is_maps\*
$chars     = Get-ChildItem -Include $includes $srcdir\chars\*
$harlots   = Get-ChildItem -Include $includes $srcdir\chars-harlots\*
$creatures = Get-ChildItem -Include $includes $srcdir\creatures\*
$eqpt      = Get-ChildItem -Include $includes $srcdir\eqpt\*

# in these folders, i use filename prepend tags to sort everything.  char-male-elf-randomstringfilenamefromtheinternet.jpg
# this is a lot of work, but I've found it to be worth it, ymmv.  not telling anyone what to do.

function get-randomimage {
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=1)]
        [string[]]$source,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, Position=2)]
        [string]$filter
    )
    if ($filter){
        $regex = "\w*$filter\w*"
        $source2 = $source | where-object { $_ -match "$regex" }
        $source = $source2
    }
    try {
        $item = $source | random
        if ($IsMacOS){ 
            open $item
        } else { 
            # write-output $item
            $item | invoke-item
        }
        
    } catch {
        write-error $_
    }
}

<#
# this is official

source the script so the function can be called.

get-randomimage -source $droids -strmatch robot
get-randomimage -source $droids -strmatch vision
get-randomimage -source $clubs -strmatch bar

# this is convenient and it works
get-randomimage $clubs bar
get-randomimage $droids robot
get-randomimage $droids vision
#>

$imgs = @{}
$imgs.add("habs",$hab_ext)
$imgs.add("areas",$hab_int)
$imgs.add("rooms",$hab_rooms)
$imgs.add("clubs",$clubs)
$imgs.add("chars",$chars)
$imgs.add("bots",$droids)
$imgs.add("eqpt",$eqpt)
$imgs.add("cars",$vehicle)
$imgs.add("ships",$ships)
$imgs.add("cardbase",$cardbase)
$imgs.add("cardsci",$cardsci)

function get-rhi {
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=1)]
        [string]$key,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, Position=2)]
        [string]$strmatch
    )
	$source = $imgs[$key]
    if ($strmatch){
        $regex = "\w*$strmatch\w*"
        $source2 = $source | where-object { $_ -match "$regex" }
        $source = $source2
    }
    $source | random | invoke-item
}

# public domain.  you're encouraged to make this script your own.
