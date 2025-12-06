Class {
	#name : #SMenuUserDescription,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'builder',
		'owner',
		'itemList'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #accessing }
SMenuUserDescription class >> owner: aMenuUserDescription [

	^ self new owner: aMenuUserDescription; yourself
]

{ #category : #adding }
SMenuUserDescription >> addItem: aSMenuUserDescription [ 
	itemList add: aSMenuUserDescription
]

{ #category : #accessing }
SMenuUserDescription >> builder [

	builder ifNil: [ builder := SMenuBuilder new ].
	^ builder 
]

{ #category : #initialization }
SMenuUserDescription >> initialize [ 

	super initialize.
	itemList := OrderedCollection new.
]

{ #category : #accessing }
SMenuUserDescription >> item: aSymbol [
	"Set my name and my label with aSymbol (the label and the name as the same by default) and register myself as a child of my owner"

	^ self builder newSubItem
		  name: aSymbol;
		  label: aSymbol asString
]

{ #category : #accessing }
SMenuUserDescription >> owner: aSMenuUserDescription [ 
	owner := aSMenuUserDescription
]
