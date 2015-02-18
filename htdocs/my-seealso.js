var mySeeAlso = new SeeAlsoCollection();

mySeeAlso.services =  {
    'isbn2wikipedia' : new SeeAlsoService(
        "http://ws.gbv.de/seealso/isbn2wikipedia/"
    ),
    'pnd2wikipedia' : new SeeAlsoService(
        "http://ws.gbv.de/seealso/pnd2wikipedia/"
    ),
   'pnd2gso' : new SeeAlsoService( 
         "http://ws.gbv.de/seealso/pnd2gso/" 
    ),
    'pnd2vd17' : new SeeAlsoService( 
        "http://ws.gbv.de/seealso/pnd2vd17/"
    ),
  'isbn2librarything' : new SeeAlsoService("http://ws.gbv.de/seealso/isbn2librarything/"),
  'isbn2hannoverbib' : new SeeAlsoService("http://ws.gbv.de/seealso/isbn2hannoverbib/"),
  'isbn2gbvlib' : new SeeAlsoService("http://ws.gbv.de/seealso/isbn2gbvlib/"),
  'isbn2gso' : new SeeAlsoService("http://ws.gbv.de/seealso/isbn2gbv/"),
  'isbn2worldcat' : new SeeAlsoService("http://ws.gbv.de/seealso/isbn2worldcat/"),
  'wikipediatitles-de': new MediaWikiTitleService("http://de.wikipedia.org/"),
  'googlebooksearch' : new GoogleBookSearchService(),
  'bibkey2bibsonomy' : new BibSonomyTaggedService()
};

mySeeAlso.views = {
    'seealso-csv' : new SeeAlsoCSV(),
    'seealso-ul' : new SeeAlsoUL()
};

mySeeAlso.replaceTagsOnLoad();

