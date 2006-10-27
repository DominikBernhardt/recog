#############################################################################
##  
##  PackageInfo.g for the package `recog'                     
##                                                            Max Neunhoeffer
##                                                                Akos Seress
##                                                                     et al.
##  

##  With a new release of the package at least the entries .Version, .Date and
##  .ArchiveURL must be updated.

SetPackageInfo( rec(

##  This is case sensitive, use your preferred spelling.
PackageName := "recog",

##  This may be used by a default banner or on a Web page, should fit on
##  one line.
Subtitle := "A collection of group recognition methods",
Version := "1.0",
##  Please adjust also the VERSION file in the package directory when
##  changing this.

##  Release date of the current version in dd/mm/yyyy format.
#Date := "20/06/2003",  # not yet released

ArchiveURL := "http://www.math.rwth-aachen.de/~Max.Neunhoeffer/Computer/Software/Gap/recog/recog-1.0",

ArchiveFormats := ".tar.gz",

#TextFiles := ["init.g", ......],
#BinaryFiles := ["doc/manual.dvi", ......],


Persons := [
  rec( 
    LastName      := "Brooksbank",
    FirstNames    := "Peter",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "pbrooksb@bucknell.edu",
    WWWHome       := "http://www.facstaff.bucknell.edu/pbrooksb/",
    PostalAddress := Concatenation( [
                       "Peter A. Brooksbank\n",
                       "Mathematics Department\n",
                       "Bucknell University\n",
                       "Lewisburg, PA 17837\n",
                       "USA" ] ),
    Place         := "Lewisburg",
    Institution   := "Bucknell University"
  ),
  rec( 
    LastName      := "Law",
    FirstNames    := "Maska",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "maska@maths.uwa.edu.au",
    WWWHome       := "http://www.maths.uwa.edu.au/~maska/",
    PostalAddress := Concatenation( [
                       "Maska Law\n",
                       "University of Western Australia\n",
                       "School of Mathematics and Statistics\n",
                       "35 Stirling Highway\n",
                       "Crawley 6009\n",
                       "Western Australia" ] ),
    Place         := "Perth",
    Institution   := "University of Western Australia"
  ),
  rec( 
    LastName      := "Neunhoeffer",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "max.neunhoeffer@math.rwth-aachen.de",
    WWWHome       := "http://www.math.rwth-aachen.de/~Max.Neunhoeffer",
    PostalAddress := Concatenation( [
                       "Max Neunhoeffer\n",
                       "Lehrstuhl D fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52056 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen"
  ),
  rec( 
    LastName      := "Niemeyer",
    FirstNames    := "Alice",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "alice@maths.uwa.edu.au",
    WWWHome       := "http://www.maths.uwa.edu.au/~alice/",
    PostalAddress := Concatenation( [
                       "Alice C. Niemeyer\n",
                       "University of Western Australia\n",
                       "School of Mathematics and Statistics\n",
                       "35 Stirling Highway\n",
                       "Crawley 6009\n",
                       "Western Australia" ] ),
    Place         := "Perth",
    Institution   := "University of Western Australia"
  ),
  rec( 
    LastName      := "Seress",
    FirstNames    := "Akos",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "akos@math.ohio-state.edu",
    WWWHome       := "http://www.math.ohio-state.edu/~akos/",
    PostalAddress := Concatenation( [
                       "Akos Seress\n",
                       "714 Math Tower\n",
                       "231 W 18th ave\n",
                       "Columbus, OH  43210\n",
                       "USA" ] ),
    Place         := "Columbus",
    Institution   := "Ohio-state University at Columbus"
  ),
  
],

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "deposited"     for packages for which the GAP developers agreed 
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages 
##    "other"         for all other packages
##
# Status := "accepted",
Status := "dev",

##  You must provide the next two entries if and only if the status is 
##  "accepted" because is was successfully refereed:
# format: 'name (place)'
# CommunicatedBy := "Mike Atkinson (St. Andrews)",
#CommunicatedBy := "",
# format: mm/yyyy
# AcceptDate := "08/1999",
#AcceptDate := "",

README_URL := 
  "http://www.math.rwth-aachen.de/~Max.Neunhoeffer/Computer/Software/Gap/recog/README.recog",
PackageInfoURL := 
  "http://www.math.rwth-aachen.de/~Max.Neunhoeffer/Computer/Software/Gap/recog/PackageInfo.g",

##  Here you  must provide a short abstract explaining the package content 
##  in HTML format (used on the package overview Web page) and an URL 
##  for a Webpage with more detailed information about the package
##  (not more than a few lines, less is ok):
##  Please, use '<span class="pkgname">GAP</span>' and
##  '<span class="pkgname">MyPKG</span>' for specifing package names.
##  
# AbstractHTML := "This package provides  a collection of functions for \
# computing the Smith normal form of integer matrices and some related \
# utilities.",
#AbstractHTML := 
#  "The <span class=\"pkgname\">Example</span> package, as its name suggests, \
#   is an example of how to create a <span class=\"pkgname\">GAP</span> \
#   package. It has little functionality except for being a package",
#
PackageWWWHome := "http://www.math.rwth-aachen.de/~Max.Neunhoeffer/Computer/Software/Gap/recog.html",
#               
PackageDoc := rec(
  BookName  := "recog",
  Archive := "http://www.math.rwth-aachen.de/~Max.Neunhoeffer/Computer/Software/Gap/recog/recogdoc.tar.gz",
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "recog - a collection of group recognition methods",
  Autoload  := true
),


Dependencies := rec(
  GAP := ">=4.4.8",
  NeededOtherPackages := [["GAPDoc", ">= 0.99"],["gensift", ">= 0.0"],
                          ["Orb", ">= 1.2"],["GenSS", ">= 0.2"],
                          ["recogbase", ">= 1.0"]],
  SuggestedOtherPackages := [],
  ExternalConditions := []
),

AvailabilityTest := function()
  return true;
end,

##  The LoadPackage mechanism can produce a default banner from the info
##  in this file. If you are not happy with it, you can provide a string
##  here that is used as a banner. GAP decides when the banner is shown and
##  when it is not shown. *optional* (note the ~-syntax in this example)
#BannerString := Concatenation( 
#  "----------------------------------------------------------------\n",
#  "Loading  recog ", ~.Version, "\n",
#  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
#        " (", ~.Persons[1].WWWHome, ")\n",
#  "   ", ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName,
#        " (", ~.Persons[2].WWWHome, ")\n",
#  "For help, type: ?recog package \n",
#  "----------------------------------------------------------------\n" ),

Autoload := false,

##  *Optional*, but recommended: path relative to package root to a file which 
##  contains as many tests of the package functionality as sensible.
TestFile := "tst/TestAll.g",

##  *Optional*: Here you can list some keyword related to the topic 
##  of the package.
# Keywords := ["Smith normal form", "p-adic", "rational matrix inversion"]
Keywords := []

));


