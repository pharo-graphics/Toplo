Trait {
	#name : #TToCircularMenuList,
	#instVars : [
		'defaultSectorRadialGap'
	],
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'t - circular menu list' }
TToCircularMenuList >> defaultSectorRadialGap [

	^ defaultSectorRadialGap
]

{ #category : #'t - circular menu list' }
TToCircularMenuList >> defaultSectorRadialGap: aNumber [

	defaultSectorRadialGap := aNumber.
	self requestConfiguration
]
