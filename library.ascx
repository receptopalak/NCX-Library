<%@ Control Language="C#" AutoEventWireup="true" CodeFile="library.ascx.cs" Inherits="library_Component_turf" %>



<script>

	ncx = {};

	ncx.library = {};
	
	
	ncx.library.highlight = function(options){
	
		
		var stParams = ncol3map.get("startupParameters");
		ol.nc.Util.getFeaturesFromNetgis({
			webgisUrl: stParams.getWebgisUrl(),
			workspaceName: stParams["Workspace"],
			sessionId: stParams["SessionId"],
			maxRecordCount: stParams["MaxRecordCount"],
			layerName: options.layername,
			countOnly: true,
			filter: "<PropertyIsEqualTo regularExpressions=\"false\"><PropertyName>" + options.field + "</PropertyName><Literal>" + options.value + "</Literal></PropertyIsEqualTo>",
			successFunction: function (response) {


					var features = ol.nc.Util.parseGetInfoExResult(response, { projection: ncol3map.getView().getProjection() });

					var stParams = ncol3map.get("startupParameters");

					var zoomratio = stParams.ZoomRatio;
					if (zoomratio != null) {
						zoomratio = parseInt(zoomratio);
					}


					currentFeature = features[0];

					ncol3map.getView().bufferfit(currentFeature.getGeometry().getExtent(), { zoomrate: zoomratio });



			   ol.nc.NetgisSearch.highlightFeatures({ map: ncol3map, features: ol.nc.Util.parseGetInfoExResult(response, this), extraData: this.extraData });
			 },
			errorFunction: function (error) {
				console.debug(error);
			}
		});
		
	}



</script>