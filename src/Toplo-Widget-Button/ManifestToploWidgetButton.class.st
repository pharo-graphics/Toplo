"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestToploWidgetButton',
	#superclass : 'PackageManifest',
	#category : 'Toplo-Widget-Button-Manifest',
	#package : 'Toplo-Widget-Button',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestToploWidgetButton class >> ruleEqualsTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#TToCheckable #isChecked #false)) #'2023-10-02T19:00:27.665331+02:00') #(#(#RGMethodDefinition #(#TToCheckable #isUnchecked #false)) #'2023-10-02T19:00:36.574539+02:00') )
]
