

#To install Krona
         
     conda create --yes -n krona krona
     conda activate krona
     
     #delete link
 
    rm -rf ~/miniconda3/envs/ngs/opt/krona/taxonomy

    # create directory for db to live in
    mkdir -p ~/krona/taxonomy

    # simbolic link
     ln -s ~/krona/taxonomy ~/miniconda3/envs/ngs/opt/krona/taxonomy
     
     # build database
     ktUpdateTaxonomy.sh ~/krona/taxonomy
     # Kraken2
     # cut .kraken file 
     
    cat evol1.kraken | cut -f 2,3 > evol1.kraken.krona
    #Make krona
    
     ktImportTaxonomy evol1.kraken.krona
    
