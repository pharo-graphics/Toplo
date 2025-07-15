"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestToploMenuRegistration,
	#superclass : #PackageManifest,
	#category : #'Toplo-MenuRegistration-Manifest'
}

{ #category : #'code-critics' }
ManifestToploMenuRegistration class >> ruleEqualsTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ToMenuBuilder #onlyItems #false)) #'2025-07-01T09:42:52.907349+02:00') )
]

{ #category : #'code-critics' }
ManifestToploMenuRegistration class >> ruleGuardingClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ToMenuBuilder #handleGroupsUsage: #false)) #'2025-07-15T14:51:25.116241+02:00') )
]

{ #category : #'code-critics' }
ManifestToploMenuRegistration class >> ruleNotEliminationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ToMenuBuilder #onlyItems #false)) #'2025-07-15T14:54:16.096473+02:00') )
]
