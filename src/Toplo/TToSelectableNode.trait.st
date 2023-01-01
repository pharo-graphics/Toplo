Trait {
	#name : #TToSelectableNode,
	#instVars : [
		'selected'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #initialization }
TToSelectableNode >> initializeSelectable [


]

{ #category : #'t - selectable accessing' }
TToSelectableNode >> selected [

	^ selected ifNil: [ selected := false ]
]

{ #category : #'t - selectable accessing' }
TToSelectableNode >> selected: aBoolean [

	selected := aBoolean
]
