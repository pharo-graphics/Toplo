Class {
	#name : #ToStyleRuleDep,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'looks'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #operating }
ToStyleRuleDep >> canBeAppliedTo: anElement [

	| engine |
	engine := ToStyleSelectorInterpreter new.
	^ self selectors anySatisfy: [ :s |
		  engine check: s on: anElement.
		  engine result ]
]

{ #category : #initialization }
ToStyleRuleDep >> initialize [ 

	super initialize.
	selectors := OrderedCollection new.
	looks := OrderedCollection new
]

{ #category : #accessing }
ToStyleRuleDep >> looks [

	^ looks
]

{ #category : #accessing }
ToStyleRuleDep >> selectors [

	^ selectors 
]

{ #category : #accessing }
ToStyleRuleDep >> selectors: aCollectionOfSelectors looks: aCollectionOfLooks [

	selectors addAll: aCollectionOfSelectors.
	looks addAll: aCollectionOfLooks
]
