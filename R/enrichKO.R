#' KO enrichment for microbiome data
#'
#' @param gene a vector of K gene id (e.g. K00001) or EC id (e.g. 1.1.1.27).
#' @param pvalueCutoff adjusted pvalue cutoff on enrichment tests to report.
#' @param pAdjustMethod one of "holm","hochberg","hommel","bonferroni","BH",
#' "BY","fdr","none".
#' @param universe universe background genes. If missing, use all K genes.
#' @param minGSSize minimal size of genes annotated by KEGG term for testing.
#' @param maxGSSize maximal size of genes annotated for testing.
#' @param qvalueCutoff qvalue cutoff on enrichment tests to report.
#' @importFrom clusterProfiler enricher
#' @importFrom methods slot<-
#' @return A \code{enrichResult} instance.
#' @export
#' @examples
#'
#'   data(Rat_data)
#'   ko <- enrichKO(Rat_data)
#'   head(ko)
#'
enrichKO <- function(gene,
                     pvalueCutoff      = 0.05,
                     pAdjustMethod     = "BH",
                     universe,
                     minGSSize         = 10,
                     maxGSSize         = 500,
                     qvalueCutoff      = 0.2) {
    
    if (all(grepl("^K", gene))){
        use.gson <- ko_gson
    }else{
        use.gson <- ec_gson 
    }

    res <- enricher(gene,
                    gson = use.gson,
                    pvalueCutoff  = pvalueCutoff,
                    pAdjustMethod = pAdjustMethod,
                    universe      = universe,
                    minGSSize     = minGSSize,
                    maxGSSize     = maxGSSize,
                    qvalueCutoff  = qvalueCutoff)
    if (is.null(res))
        return(res)

    slot(res,"ontology") <- "KEGG"
    slot(res,"organism") <- "microbiome"

    return(res)
}




