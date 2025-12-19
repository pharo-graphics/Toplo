Class {
	#name : #ToDiffElement,
	#superclass : #ToElement,
	#instVars : [
		'srcAlbum',
		'targetAlbum',
		'difference',
		'joinMappings'
	],
	#category : #'Toplo-Widget-Diff'
}

{ #category : #'accessing - colors' }
ToDiffElement >> additionHighlightColor [
	^ Color green 
]

{ #category : #highlighting }
ToDiffElement >> applyHighlightTo: src fromModifications: modifications [

	modifications do: [ :join |
			join lineRange do: [ :idx |
				(src next editor segmentCollector segments at: idx) text background: join color ] ]
]

{ #category : #highlighting }
ToDiffElement >> applyHighlights [

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
ToDiffElement >> calculateDifference [
	"Calculate the difference of the src and dst.
	Use src/dest morphs text, because we may want to compare the pretty printed text"
	self difference: (TextDiffBuilder
			 from: self srcAlbum text
			 to: self targetAlbum text) buildPatchSequence
]

{ #category : #private }
ToDiffElement >> calculateJoinMappings [
	"Calculate the join parameters between src and dst and store in joinMappings."

	self joinMappings: self calculatedJoinMappings
]

{ #category : #private }
ToDiffElement >> calculatedJoinMappings [
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
ToDiffElement >> colorForType: type [
	"Anwser the color to use for the given change type."

	^ {
		  self matchColor.
		  (Color green alpha: 0.2).
		  (Color red alpha: 0.2).
		  (Color yellow alpha: 0.2) } at:
		  (#( match addition removal modification ) indexOf: type)
]

{ #category : #initialization }
ToDiffElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
ToDiffElement >> difference [
	"Answer the value of difference"

	^ difference
]

{ #category : #initialization }
ToDiffElement >> difference: anObject [
	"Set the value of difference"

	difference := anObject
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
	self
		calculateDifference;
		applyHighlights
]

{ #category : #initialization }
ToDiffElement >> initialize [

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
ToDiffElement >> initializeAlbums [

	srcAlbum := ToAlbum new.
	srcAlbum next beReadonlyWithSelection.
	targetAlbum := ToAlbum new.
	targetAlbum next beReadonlyWithSelection.
]

{ #category : #private }
ToDiffElement >> joinMappings [
	"Answer the join parameters between src and dst."

	^ joinMappings ifNil: [ self calculateJoinMappings ]
]

{ #category : #accessing }
ToDiffElement >> joinMappings: aCollection [ 
	joinMappings := aCollection
]

{ #category : #private }
ToDiffElement >> joinSectionClass [
	"Answer the class to use for a new join section."

	^ JoinSection
]

{ #category : #'accessing - colors' }
ToDiffElement >> matchColor [

	^ Color transparent
]

{ #category : #private }
ToDiffElement >> newJoinSection [
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
ToDiffElement >> newJoinSectionFrom: srcRange to: dstRange [
	"Answer a new join section."

	| sourceParagraphLines destinationParagraphLines sourceTopPixelPosition sourceBottomPixelPosition destinationTopPixelPosition destinationBottomPixelPosition type rectangleColor |
	sourceParagraphLines := self srcAlbum text rope asString lines.
	destinationParagraphLines := self targetAlbum text rope asString
		                             lines.
	type := #modification.

	rectangleColor := self colorForType: type.
	^ self newJoinSection
		  type: type;
		  srcColor: rectangleColor;
		  dstColor: rectangleColor;
		  srcLineRange: srcRange;
		  dstLineRange: dstRange
]

{ #category : #private }
ToDiffElement >> newMatchJoinSectionFrom: srcRange to: dstRange [
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
ToDiffElement >> removalHighlightColor [

	^ Color lightRed
]

{ #category : #accessing }
ToDiffElement >> srcAlbum [

	^ srcAlbum
]

{ #category : #initialization }
ToDiffElement >> srcText: aText [

	srcAlbum text: aText
]

{ #category : #accessing }
ToDiffElement >> targetAlbum [

	^ targetAlbum
]

{ #category : #initialization }
ToDiffElement >> targetText: aText [

	targetAlbum text: aText
]
