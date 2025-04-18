# Research Reproducibility Issues
Follows the list of information that is retrieved from online sources, therefore, they may cause issues regarding research reproducibility.

- compounds with HMDB IDs `HMDB29244`, `HMDB29245`, and `HMDB29246` are excluded from pathway evaluation (annotation of unannotated features which are part of some pathway that is present in the analyzed sample).
  - possible explanation: these compounds are very similar and they probably cause errors since they are non-specifically related to various pathways (very late stage biosynthesis)
  - primary affected functions: `multilevelannotationstep3`
  - transitively affected functions: `multilevelannotation`
- attributes `BRITE`, `PATHWAYS`, and `DBLINKS` are retrieved from online KEGG database
  - conditionally (defaults to not to) the `HMDB ID` and `LipidMaps ID` are extracted from `DBLINKS` if present
  - implications: since these are not important attributes and are added to the result just for convenience, the annotation algorithm is unaffected
  - primary affected functions: `Annotationbychemical_IDschild`, `Annotationbychemical_IDschildsimple`, `Annotationbychemical_IDschild_multilevel`
  - transitively affected functions: `simpleAnnotation`, `multilevelannotation`, `Annotationbychemical_IDs`
- attributes `FORMULA`, `NAME`, and `EXACT_MASS` are retrieved from online KEGG database
  - primary affected functions: `get_mz_by_KEGGcompoundIDs`, `get_mz_by_KEGGdrugIDs`
- attributes `COMPOUND`, `MODULE` are retrieved from online KEGG database
  - primary affected function: `get_mz_by_KEGGpathwayIDs`
  - transitively affected functions: `get_mz_by_KEGGspecies`
- based on the KEGG's species code a list of pathways is retrieved from online KEGG database
  - primary affected function: `get_mz_by_KEGGspecies`
- legacy KEGG annotation  (needs verification in case of interest)
  - all data is retrieved from various online sources: `Adduct`, `Query.m/z`, `Search mass tolerance range (+/-)`, `Metlin`, `Compound.Name`, `Chemical.Formula`, `Exact Mass`, `CASID`, `KEGG.Compound.ID`, `KEGG.Pathway.ID`, `KEGG.Pathway.Name`, `HMDB.ID`, `PubChem.Substance.ID`, `ChEBI.ID`, `LIPID.MAPS.ID`, `KEGG.Brite.Category`, `KEGG.Disease.ID`, `KEGG.Drug.ID`, `KEGG.Environ.ID`
  - primary affected function: `feat.batch.annotation.child`
  - transitively affected functions: `KEGG.annotationvold`
- ChemSpider annotation (needs verification in case of interest)
  - all data is retrieved from various online sources: `Adduct`, `Query.m/z`, `Search mass tolerance range (+/-)`, `ChemspiderID`, `CommonName`, `Molecular.Formula`, `SMILES`, `InChI`, `InChIKey`, `AverageMass`, `MolecularWeight`, `MonoisotopicMass`, `NominalMass`, `ALogP`, `XLogP`, `Structure`, `KEGG.Compound.ID`, `HMDB`, `LipidMAPS`, `PubChem`, `MassBank`, `BioCyc`, `SMPDB`, `EPA.DSSTox`, `EPA.Toxcast`, `Pesticide.Common.Names`, `ChEMBL`, `ChEBI`, `NIST.Chem.WebBook`, `WikiPathways`, `DrugBank`, `Comparative Toxicogenomics Database`, `ACToR: Aggregated Computational Toxicology Resource`
  - primary affected functions:`chspider.batch.annotation.child`
  - transitively affected functions: `ChemSpider.annotation`