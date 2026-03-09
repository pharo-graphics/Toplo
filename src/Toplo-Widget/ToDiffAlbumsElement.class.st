Class {
	#name : #ToDiffAlbumsElement,
	#superclass : #ToElement,
	#instVars : [
		'leftLabel',
		'rightLabel',
		'srcAlbum',
		'targetAlbum',
		'joinMappings',
		'difference'
	],
	#category : #'Toplo-Widget-Diff'
}

{ #category : #'accessing - colors' }
ToDiffAlbumsElement >> additionHighlightColor [
	^ Color green 
]

{ #category : #highlighting }
ToDiffAlbumsElement >> applyHighlightTo: src fromModifications: modifications [

	modifications do: [ :join |
			join lineRange do: [ :idx |
					| deco segment |
					segment := src next editor segmentCollector segments at: idx.
					deco := (AlbSubtextElement editorElement: src next)
						        interval: (segment textStart to: segment textEnd);
						        yourself.
					deco addEventHandler: AlbSubtextElementEventHandler new.
					deco background: join color.
					deco border: BlBorder empty.
					src next frontLayer addChild: deco ] ]
]

{ #category : #highlighting }
ToDiffAlbumsElement >> applyHighlights [

	| modifications |
	self calculateDifference.
	self calculateJoinMappings.

	modifications := self joinMappings reject: [ :el | el type = #match ].
	self
		applyHighlightTo: self srcAlbum
		fromModifications: (modifications collect: [ :j | j src ]).

	self
		applyHighlightTo: self targetAlbum
		fromModifications: (modifications collect: [ :j | j dst ])
]

{ #category : #private }
ToDiffAlbumsElement >> calculateDifference [
	"Calculate the difference of the src and dst.
	Use src/dest morphs text, because we may want to compare the pretty printed text"

	self difference: (TextDiffBuilder
			 from: self srcAlbum text
			 to: self targetAlbum text) buildPatchSequence
]

{ #category : #private }
ToDiffAlbumsElement >> calculateJoinMappings [
	"Calculate the join parameters between src and dst and store in joinMappings."

	self joinMappings: self calculatedJoinMappings
]

{ #category : #private }
ToDiffAlbumsElement >> calculatedJoinMappings [
	"Calculate the join parameters between src and dst and answer"

	| sourceLine destinationLine joins destinationRunStart sourceRunStart destinationRunEnd sourceRunEnd matchDestinationStart matchSourceStart |
	sourceLine := destinationLine := 0.
	joins := OrderedCollection new.
	destinationRunStart := destinationRunEnd := sourceRunStart := sourceRunEnd := matchSourceStart := matchDestinationStart := 0.
	self difference
		do: [ :p |
			p key = #match
				ifTrue: [
					sourceLine := sourceLine + 1.
					destinationLine := destinationLine + 1.
					matchSourceStart = 0
						ifTrue: [
							matchSourceStart := sourceLine.
							matchDestinationStart := destinationLine ].
					(destinationRunStart > 0 or: [ sourceRunStart > 0 ])
						ifTrue: [
							sourceRunStart = 0
								ifTrue: [ sourceRunStart := sourceLine ].
							destinationRunStart = 0
								ifTrue: [ destinationRunStart := destinationLine ].
							sourceRunEnd = 0
								ifTrue: [ sourceRunEnd := sourceRunStart - 1 ].
							destinationRunEnd = 0
								ifTrue: [ destinationRunEnd := destinationRunStart - 1 ].
							joins
								add:
									(self newJoinSectionFrom: (sourceRunStart to: sourceRunEnd) to: (destinationRunStart to: destinationRunEnd)).
							destinationRunStart := destinationRunEnd := sourceRunStart := sourceRunEnd := 0 ] ].
			p key = #remove
				ifTrue: [
					matchSourceStart > 0
						ifTrue: [
							joins
								add:
									(self newMatchJoinSectionFrom: (matchSourceStart to: sourceLine) to: (matchDestinationStart to: destinationLine)).
							matchSourceStart := matchDestinationStart := 0 ].
					sourceLine := sourceLine + 1.
					sourceRunStart = 0
						ifTrue: [ sourceRunStart := sourceLine ].
					sourceRunEnd := sourceLine ].
			p key = #insert
				ifTrue: [
					matchSourceStart > 0
						ifTrue: [
							joins
								add:
									(self newMatchJoinSectionFrom: (matchSourceStart to: sourceLine) to: (matchDestinationStart to: destinationLine)).
							matchSourceStart := matchDestinationStart := 0 ].
					destinationLine := destinationLine + 1.
					sourceRunStart > 0
						ifTrue: [
							sourceRunEnd = 0
								ifTrue: [ sourceRunEnd := sourceRunStart ].
							destinationRunEnd = 0
								ifTrue: [ destinationRunEnd := destinationRunStart ].
							joins
								add:
									(self newJoinSectionFrom: (sourceRunStart to: sourceRunEnd) to: (destinationRunStart to: destinationRunEnd)).
							destinationRunStart := destinationRunEnd := sourceRunStart := sourceRunEnd := 0 ].
					destinationRunStart = 0
						ifTrue: [ destinationRunStart := destinationLine ].
					destinationRunEnd := destinationLine ] ].
	sourceLine := sourceLine + 1.
	destinationLine := destinationLine + 1.
	(destinationRunStart > 0 or: [ sourceRunStart > 0 ])
		ifTrue: [
			sourceRunStart = 0
				ifTrue: [ sourceRunStart := sourceLine ].
			destinationRunStart = 0
				ifTrue: [ destinationRunStart := destinationLine ].
			sourceRunEnd = 0
				ifTrue: [ sourceRunEnd := sourceRunStart - 1 ].
			destinationRunEnd = 0
				ifTrue: [ destinationRunEnd := destinationRunStart - 1 ].
			joins
				add: (self newJoinSectionFrom: (sourceRunStart to: sourceRunEnd) to: (destinationRunStart to: destinationRunEnd)) ].
	matchSourceStart > 0
		ifTrue: [
			joins
				add:
					(self newMatchJoinSectionFrom: (matchSourceStart to: sourceLine - 1) to: (matchDestinationStart to: destinationLine - 1)) ].
	^ joins
]

{ #category : #'accessing - colors' }
ToDiffAlbumsElement >> colorForType: type [
	"Anwser the color to use for the given change type."

	^ {
		  self matchColor.
		  (Color green alpha: 0.2).
		  (Color red alpha: 0.2).
		  (Color yellow alpha: 0.2) } at:
		  (#( match addition removal modification ) indexOf: type)
]

{ #category : #initialization }
ToDiffAlbumsElement >> defaultLayout [
	" don't use vertical or horizontal to allow vertical centering of children "

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToDiffAlbumsElement >> difference [
	"Answer the value of difference"

	^ difference
]

{ #category : #initialization }
ToDiffAlbumsElement >> difference: anObject [
	"Set the value of difference"

	difference := anObject
]

{ #category : #initialization }
ToDiffAlbumsElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self matchParent.
	self padding: (BlInsets all: 1).
	self initializeAlbums.
	self addChildren: {
			srcAlbum.
			targetAlbum }
]

{ #category : #initialization }
ToDiffAlbumsElement >> initializeAlbums [

	srcAlbum := ToAlbum new.
	srcAlbum next beReadonlyWithSelection.
	targetAlbum := ToAlbum new.
	targetAlbum next beReadonlyWithSelection.
]

{ #category : #private }
ToDiffAlbumsElement >> joinMappings [
	"Answer the join parameters between src and dst."

	^ joinMappings ifNil: [ self calculateJoinMappings ]
]

{ #category : #accessing }
ToDiffAlbumsElement >> joinMappings: aCollection [

	joinMappings := aCollection
]

{ #category : #private }
ToDiffAlbumsElement >> joinSectionClass [
	"Answer the class to use for a new join section."

	^ JoinSection
]

{ #category : #'accessing - colors' }
ToDiffAlbumsElement >> matchColor [

	^ Color transparent
]

{ #category : #private }
ToDiffAlbumsElement >> newJoinSection [
	"Answer a new join section."

	^self joinSectionClass new
		srcColor: (self colorForType: #modification);
		dstColor: (self colorForType: #modification);
		borderWidth: 1;
		additionHighlightColor: self additionHighlightColor;
		removalHighlightColor: self removalHighlightColor;
		addDependent: self;
		yourself
]

{ #category : #private }
ToDiffAlbumsElement >> newJoinSectionFrom: srcRange to: dstRange [
	"Answer a new join section."

	| sourceParagraphLines destinationParagraphLines type rectangleColor |
	sourceParagraphLines := self srcAlbum text rope asString lines.
	destinationParagraphLines := self targetAlbum text rope asString
		                             lines.
	type := #modification.
	srcRange first > sourceParagraphLines size ifTrue: [
		type := #addition ].
	dstRange first > destinationParagraphLines size ifTrue: [
		type := #removal ].
	rectangleColor := self colorForType: type.
	^ self newJoinSection
		  type: type;
		  srcColor: rectangleColor;
		  dstColor: rectangleColor;
		  srcLineRange: srcRange;
		  dstLineRange: dstRange
]

{ #category : #private }
ToDiffAlbumsElement >> newMatchJoinSectionFrom: srcRange to: dstRange [
	"Answer a new match join section."

	| c |
	c := self colorForType: #match.
	^ self newJoinSection
		  type: #match;
		  borderWidth: 0;
		  srcColor: c;
		  dstColor: c;
		  srcLineRange: srcRange;
		  dstLineRange: dstRange
]

{ #category : #'accessing - colors' }
ToDiffAlbumsElement >> removalHighlightColor [

	^ Color lightRed
]

{ #category : #accessing }
ToDiffAlbumsElement >> srcAlbum [

	^ srcAlbum
]

{ #category : #accessing }
ToDiffAlbumsElement >> targetAlbum [

	^ targetAlbum
]
