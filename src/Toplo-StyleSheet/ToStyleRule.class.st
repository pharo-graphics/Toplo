Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'looks'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #initialization }
ToStyleRule >> initialize [ 

	super initialize.
	selectors := OrderedCollection new.
	looks := OrderedCollection new
]

{ #category : #accessing }
ToStyleRule >> selectors: aCollectionOfStyleSelectors looks: aCollectionOfLooks [

	selectors addAll: aCollectionOfStyleSelectors.
	looks addAll: aCollectionOfLooks
]
