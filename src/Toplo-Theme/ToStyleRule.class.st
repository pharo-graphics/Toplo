Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'looks'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #operating }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToElementSelectorEngine new.
	^ self selectors anySatisfy: [ :s |
		  engine check: s on: anElement.
		  engine result ]
]

{ #category : #initialization }
ToStyleRule >> initialize [ 

	super initialize.
	selectors := OrderedCollection new.
	looks := OrderedCollection new
]

{ #category : #accessing }
ToStyleRule >> looks [

	^ looks
]

{ #category : #accessing }
ToStyleRule >> selectors [

	^ selectors 
]

{ #category : #accessing }
ToStyleRule >> selectors: aCollectionOfSelectors looks: aCollectionOfLooks [

	selectors addAll: aCollectionOfSelectors.
	looks addAll: aCollectionOfLooks
]
