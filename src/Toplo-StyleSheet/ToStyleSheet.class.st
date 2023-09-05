Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #adding }
ToStyleSheet >> addRule: aStyleRule [

	rules add: aStyleRule 
]

{ #category : #initialization }
ToStyleSheet >> initialize [ 

	super initialize.
	rules := OrderedCollection new.

]

{ #category : #operating }
ToStyleSheet >> looksFor: anElement [

	^ Array streamContents: [ :str |
		  (self rulesFor: anElement) do: [ :r | str nextPutAll: r looks ] ]
]

{ #category : #accessing }
ToStyleSheet >> rules [

	^ rules
]

{ #category : #operating }
ToStyleSheet >> rulesFor: anElement [

	^ self rules select: [ :r | r canBeAppliedTo: anElement ]
]

{ #category : #operating }
ToStyleSheet >> skinFor: anElement [

	| looks skin |
	looks := self looksFor: anElement.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	^ skin
]
