Class {
	#name : #ToDiffElement,
	#superclass : #ToElement,
	#instVars : [
		'albums',
		'title',
		'showOnlySource',
		'showOnlyDestination'
	],
	#category : #'Toplo-Widget-Diff'
}

{ #category : #initialization }
ToDiffElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout vertical 
]

{ #category : #initialization }
ToDiffElement >> from: old to: new [
	"Set the old (src) and new (dst) text."

	self from: old to: new contextClass: nil
]

{ #category : #initialization }
ToDiffElement >> from: old to: new contextClass: aClass [
	"Set the old (src) and new (dst) text."

	self srcText: old.
	self targetText: new.
	albums
		calculateDifference;
		applyHighlights
]

{ #category : #initialization }
ToDiffElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self matchParent.
	self padding: (BlInsets all: 1).
	title := ToDiffTitleElement new.
	albums := ToDiffAlbumsElement new.
	self addChildren: {
			albums }
]

{ #category : #accessing }
ToDiffElement >> leftLabel [

	^ title leftLabel
]

{ #category : #accessing }
ToDiffElement >> leftLabel: anObject [

	title leftLabel: anObject.
	self updateTitle.
]

{ #category : #accessing }
ToDiffElement >> rightLabel [

	^ title rightLabel
]

{ #category : #accessing }
ToDiffElement >> rightLabel: anObject [

	title rightLabel: anObject.
	self updateTitle
]

{ #category : #initialization }
ToDiffElement >> showOnlyDestination: aBoolean [

	showOnlyDestination = aBoolean ifTrue: [ ^ self ].
	showOnlySource := false.
	showOnlyDestination := aBoolean.
	self updateAlbumVisibility
]

{ #category : #initialization }
ToDiffElement >> showOnlySource: aBoolean [

	showOnlySource = aBoolean ifTrue: [ ^ self ].
	showOnlyDestination := false.
	showOnlySource := aBoolean.
	self updateAlbumVisibility
]

{ #category : #initialization }
ToDiffElement >> srcAlbum [

	^ albums srcAlbum
]

{ #category : #initialization }
ToDiffElement >> srcText: aText [

	self srcAlbum text: aText
]

{ #category : #initialization }
ToDiffElement >> targetAlbum [

	^ albums targetAlbum
]

{ #category : #initialization }
ToDiffElement >> targetText: aText [

	self targetAlbum text: aText
]

{ #category : #initialization }
ToDiffElement >> updateAlbumVisibility [

	self srcAlbum visibility: BlVisibility visible.
	self targetAlbum visibility: BlVisibility visible.
	showOnlySource ifTrue: [ self targetAlbum visibility: BlVisibility gone ].
	showOnlyDestination ifTrue: [ self srcAlbum visibility: BlVisibility gone ]
]

{ #category : #initialization }
ToDiffElement >> updateTitle [

	title isWithoutTitle
		ifTrue: [ title removeFromParent ]
		ifFalse: [
		self children first = title ifFalse: [ self addChildFirst: title ] ]
]
