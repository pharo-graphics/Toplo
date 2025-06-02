Class {
	#name : #ToMenuRegistration,
	#superclass : #Object,
	#instVars : [
		'builder',
		'childrenItems',
		'name',
		'label',
		'parentMenuItem',
		'parent',
		'precondition',
		'groupName',
		'shortcut',
		'order'
	],
	#category : #'Toplo-MenuRegistration-NewCreate'
}

{ #category : #adding }
ToMenuRegistration >> addChild: aMenuRegistration [
	childrenItems add: aMenuRegistration.
]

{ #category : #accessing }
ToMenuRegistration >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuRegistration >> builder: aBuilder [
	builder := aBuilder.
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems [
	^ childrenItems
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems: anOrderedCollectionOfMenuRegistration [
	childrenItems := anOrderedCollectionOfMenuRegistration.
]

{ #category : #accessing }
ToMenuRegistration >> groupName [
	^ groupName
]

{ #category : #accessing }
ToMenuRegistration >> groupName: aSymbol [
	groupName := aSymbol
]

{ #category : #initialization }
ToMenuRegistration >> initialize [
	super initialize.
	childrenItems := OrderedCollection new.
]

{ #category : #accessing }
ToMenuRegistration >> label [
	^ label
]

{ #category : #accessing }
ToMenuRegistration >> label: aString [
	label := aString 
]

{ #category : #accessing }
ToMenuRegistration >> name [
	^ name
]

{ #category : #accessing }
ToMenuRegistration >> name: aSymbol [
	name := aSymbol
]

{ #category : #accessing }
ToMenuRegistration >> order [

	^ order
]

{ #category : #accessing }
ToMenuRegistration >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToMenuRegistration >> parent [
	^ parent
]

{ #category : #accessing }
ToMenuRegistration >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToMenuRegistration >> parentMenuItem [

	^ parentMenuItem
]

{ #category : #accessing }
ToMenuRegistration >> parentMenuItem: aMenuRegistration [

	parentMenuItem := aMenuRegistration
]

{ #category : #accessing }
ToMenuRegistration >> precondition [
	^ precondition
]

{ #category : #accessing }
ToMenuRegistration >> precondition: aBlock [
	precondition := aBlock
]

{ #category : #accessing }
ToMenuRegistration >> shortcut [
	^ shortcut
]

{ #category : #accessing }
ToMenuRegistration >> shortcut: aString [

	shortcut := aString
]

{ #category : #'instance creation' }
ToMenuRegistration >> with: aBlock [

	| menu |
	menu := aBlock value.
	menu parent = name ifTrue: [ ^ self ].
	aBlock value builder changeParent: self for: menu name
]
