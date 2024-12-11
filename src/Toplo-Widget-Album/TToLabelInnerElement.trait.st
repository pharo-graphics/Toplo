Trait {
	#name : #TToLabelInnerElement,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
TToLabelInnerElement >> newEditor [

	^ self explicitRequirement 
]

{ #category : #'t - label inner element' }
TToLabelInnerElement >> text [

	^ self explicitRequirement 
]

{ #category : #'t - label inner element' }
TToLabelInnerElement >> text: aText [

	^ self explicitRequirement 
]
