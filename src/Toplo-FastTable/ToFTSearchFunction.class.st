"
I define a search function for a table. 
I respond to any alphanumeric element and I add a search box to the  owner table. 

I use ToFTDataSource>>#searchTable:text: as input for my searchs. 

In general, my entry point is through #keyStroke:, because I intend to react to keyboard inputs in the owner table.
"
Class {
	#name : #ToFTSearchFunction,
	#superclass : #ToFTFieldFunction,
	#instVars : [
		'currentSelIndex',
		'currentHighlightedIndexes',
		'pattern'
	],
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #'widget API' }
ToFTSearchFunction >> ghostText [
	^ 'Search...'
]

{ #category : #'event handling' }
ToFTSearchFunction >> keyDown: anEvent [
	^ self keyStroke: anEvent
]

{ #category : #'event handling' }
ToFTSearchFunction >> keyStroke: anEvent [

	anEvent keyCharacter isAlphaNumeric ifFalse: [ ^ false ].
	currentSelIndex := self table selectedIndex.
	currentHighlightedIndexes := self table highlightedIndexes.
	self showSearchFieldFromKeystrokeEvent: anEvent.
	^ true
]

{ #category : #accessing }
ToFTSearchFunction >> realSearch [
	| founds |
	founds := self table dataSource searchText: pattern.

	founds ifNotEmpty: [ self table selectIndex: founds first ].
	self table highlightIndexes: founds.

	^ founds notEmpty
]

{ #category : #initialization }
ToFTSearchFunction >> reset [
	"self search"
]

{ #category : #accessing }
ToFTSearchFunction >> searchFor: aStringOrText [
	pattern := aStringOrText asString trim.
	^ self realSearch
]

{ #category : #private }
ToFTSearchFunction >> showSearchFieldFromKeystrokeEvent: anEvent [
	| s ed founds |
	s := anEvent keyCharacter asString asText.
	founds := self searchFor: s.
	ed := RubFloatingEditorBuilder new
		customizeEditorWith: [ :editor | editor bounds: (self table bottomLeft + (0 @ 2) corner: self table bottomRight + (0 @ (editor font height + 6))) ];
		withEditedContentsDo:
				[ :contents :editor |
			contents
				ifEmpty: [ founds ifTrue: [self table selectIndex: currentSelIndex].
					self table highlightIndexes: currentHighlightedIndexes ]
				ifNotEmpty:
					[ founds := self searchFor: contents.
					founds
						ifTrue: [ editor
								setTextWith:
									(contents
										makeAllColor: self table theme textColor;
										yourself) ]
						ifFalse: [ editor
								setTextWith:
									(contents
										addAttribute: (TextColor new color: Color red);
										yourself) ] ] ];
		whenEditorEscapedDo: [ founds ifTrue: [self table selectIndex: currentSelIndex].
			self table highlightIndexes: currentHighlightedIndexes ].
	ed autoAccept: true.
	founds
		ifFalse: [ s addAttribute: (TextColor new color: Color red) ]
		ifTrue: [ s makeAllColor: self table theme textColor ].
	ed openEditorWithContents: s
]

{ #category : #updating }
ToFTSearchFunction >> textUpdated: anAnnouncement [
	self searchFor: field getTextFromModel
]
