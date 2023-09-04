Class {
	#name : #ToStyleClassSelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'elementClasses'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #accessing }
ToStyleClassSelector >> elementClass: aSymbol [

	elementClasses add: aSymbol
]

{ #category : #accessing }
ToStyleClassSelector >> elementClasses [

	^ elementClasses
]

{ #category : #accessing }
ToStyleClassSelector >> elementClasses: aCollectionOfSymbols [

	elementClasses addAll: aCollectionOfSymbols
]

{ #category : #initialization }
ToStyleClassSelector >> initialize [ 

	super initialize.
	elementClasses := OrderedCollection new
]
