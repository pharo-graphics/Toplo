Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#instVars : [
		'styleSheet'
	],
	#category : #'Toplo-Theme-Core'
}

{ #category : #initialization }
ToStyleSheetTheme >> defaultStampList [
	" skin managing need a list of unique stamps . "

	^ { }
]

{ #category : #accessing }
ToStyleSheetTheme >> name [

	^ #'StyleSheetTheme'
]

{ #category : #colors }
ToStyleSheetTheme >> printOn: aStream [

	aStream nextPutAll: '[Theme named: '; nextPutAll: self name; nextPutAll: ' ]'.
	super printOn: aStream
]

{ #category : #accessing }
ToStyleSheetTheme >> skinBuilder [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToStyleSheetTheme >> stampNamed: aSymbol [

	^ self styleSheet stampNamed: aSymbol
]

{ #category : #accessing }
ToStyleSheetTheme >> styleSheet [

	^ styleSheet
]

{ #category : #accessing }
ToStyleSheetTheme >> styleSheet: aStyleSheet [

	aStyleSheet defaultStampList: self defaultStampList.
	styleSheet := aStyleSheet
]
