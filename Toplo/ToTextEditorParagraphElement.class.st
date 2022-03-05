Class {
	#name : #ToTextEditorParagraphElement,
	#superclass : #ToTextEditorSegmentElement,
	#instVars : [
		'paragraph',
		'text',
		'cursorElements',
		'cursorStencil',
		'selection',
		'segment',
		'pieces'
	],
	#classVars : [
		'Slants',
		'Stretches'
	],
	#category : #'Toplo-Editor-UI'
}

{ #category : #'instance creation' }
ToTextEditorParagraphElement class >> fontSlantToSkia: aBlFontSlant [
	Slants ifNil: [ Slants := {
		BlFontSlant normal -> SkiaFontStyleSlant Upright.
		BlFontSlant italic -> SkiaFontStyleSlant Italic.
		BlFontSlant oblique -> SkiaFontStyleSlant Oblique
	} asDictionary ].
	
	^ Slants at: aBlFontSlant ifAbsent: [ SkiaFontStyleSlant Upright ]
]

{ #category : #'instance creation' }
ToTextEditorParagraphElement class >> fontStretchToSkia: aBlFontStretch [
	Stretches ifNil: [ Stretches := { 
		BlFontStretch condensed -> SkiaFontStyleWidth Condensed.
		BlFontStretch expanded -> SkiaFontStyleWidth Expanded.
		BlFontStretch extraCondensed -> SkiaFontStyleWidth ExtraCondensed.
		BlFontStretch extraExpanded -> SkiaFontStyleWidth ExtraExpanded.
		BlFontStretch normal -> SkiaFontStyleWidth Normal.
		BlFontStretch semiCondensed -> SkiaFontStyleWidth SemiCondensed.
		BlFontStretch semiExpanded -> SkiaFontStyleWidth SemiExpanded.
		BlFontStretch ultraCondensed -> SkiaFontStyleWidth UltraCondensed.
		BlFontStretch ultraExpanded -> SkiaFontStyleWidth UltraExpanded.
	} asDictionary ].
	^ Stretches at: aBlFontStretch ifAbsent: [ SkiaFontStyleWidth Normal ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> addCursorAt: aTextPosition [
	<return: #BrCursorElement>

	^ self
		cursorAt: aTextPosition
		ifFound: #yourself
		ifNone: [
			| aCursorElement |
			aCursorElement := self newCursor.
			aCursorElement textPosition: aTextPosition.
			cursorElements add: aCursorElement.
			self addChild: aCursorElement.
			aCursorElement ]
]

{ #category : #'private - paragraph' }
ToTextEditorParagraphElement >> addText: aBlText toBuilder: aParagraphBuilder [
	| anIterator |
	
	anIterator := aBlText iterator.
	[ anIterator hasNext ] whileTrue: [
		| eachSpan |
		
		eachSpan := anIterator nextSpan.
		
		eachSpan attributes ifNotEmpty: [ :theAttributes |
			| aFontAndStyleBuilder |
			
			"we first collect font properties and text style from the attributes"
			aFontAndStyleBuilder := BlTextFontAndStyleBuilder new.
			theAttributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: aFontAndStyleBuilder ].
		
			SkiaParagraphTextStyle newDuring: [ :aTextStyle |		
		
				aFontAndStyleBuilder hasCustomFontStyle
					ifTrue: [
						| aFontWeight aFontStretch aFontSlant |
						
						aFontWeight := aFontAndStyleBuilder hasCustomFontWeight
							ifTrue: [ aFontAndStyleBuilder fontWeight ]
							ifFalse: [ BlFontWeight normal ].
							
						aFontStretch := aFontAndStyleBuilder hasCustomFontStretch
							ifTrue: [ aFontAndStyleBuilder fontStretch ]
							ifFalse: [ BlFontStretch normal ].
							
						aFontSlant := aFontAndStyleBuilder hasCustomFontSlant
							ifTrue: [ aFontAndStyleBuilder fontSlant ]
							ifFalse: [ BlFontSlant normal ].
						
						SkiaFontStyle
							weight: aFontWeight value
							width: (self class fontStretchToSkia: aFontStretch)
							slant: (self class fontSlantToSkia: aFontSlant)
							during: [ :aSkiaFontStyle | aTextStyle fontStyle: aSkiaFontStyle ] ].

				aFontAndStyleBuilder hasCustomFontSize
					ifTrue: [ aTextStyle fontSize: aFontAndStyleBuilder resolvedFontSize value asFloat ]
					ifFalse: [ aTextStyle fontSize: self defaultFontSize ].
					
				aFontAndStyleBuilder hasCustomFamilyName
					ifTrue: [ aTextStyle fontFamily: aFontAndStyleBuilder resolvedFontFamilyName ].

				aFontAndStyleBuilder hasCustomColor
					ifTrue: [ aTextStyle color: aFontAndStyleBuilder color ]
					ifFalse: [ aTextStyle color: self defaultTextColor ].
					
				aFontAndStyleBuilder hasCustomDecoration
					ifTrue: [
						SkiaTextDecoration newDuring: [ :aSkiaDecoration |
							aFontAndStyleBuilder decoration applyOnSkiaDecoration: aSkiaDecoration.
							aTextStyle decoration: aSkiaDecoration ] ].

				aParagraphBuilder
					pushStyle: aTextStyle;
					addString: eachSpan asString;
					popStyle
				
			].
		]
		ifEmpty: [ aParagraphBuilder addString: eachSpan asString ].
		
	]
]

{ #category : #'private - paragraph' }
ToTextEditorParagraphElement >> buildParagraph [
	| aBuilder |

	aBuilder := SkiaParagraphBuilder
		style: (SkiaParagraphStyle new textStyle: (SkiaParagraphTextStyle new color: Color black; fontSize: self defaultFontSize))
		fontCollection: (SkiaFontCollection new defaultFontManager: SkiaFontManager default)
		tabSize: 4.

	self childrenDo: [ :eachElement |
		(eachElement isKindOf: BlTextElement)
			ifTrue: [ self addText: eachElement text toBuilder: aBuilder ]
			ifFalse: [
				(eachElement isKindOf: BrCursorElement)
					ifFalse: [
						aBuilder
							addPlaceholder: (SkiaParagraphPlaceholderStyle new alignMiddle extent: eachElement measuredExtent)
							charLength: (eachElement userData at: #brickEditorCharLength ifAbsent: [ 0 ]) ] ] ].
	^ aBuilder build
]

{ #category : #private }
ToTextEditorParagraphElement >> cursorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [

	^ cursorElements
		detect: [ :aCursor | aCursor textPosition = aTextPosition ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
ToTextEditorParagraphElement >> cursorElements [
	<return: #Collection of: #BrCursorElement>

	^ cursorElements
]

{ #category : #accessing }
ToTextEditorParagraphElement >> cursorStencil [
	^ cursorStencil
]

{ #category : #accessing }
ToTextEditorParagraphElement >> cursorStencil: aStencil [
	cursorStencil := aStencil
]

{ #category : #initialization }
ToTextEditorParagraphElement >> defaultFontSize [
	^ BlFont defaultFontSize
]

{ #category : #initialization }
ToTextEditorParagraphElement >> defaultSelectionColor [
	^ (Color r: 0 g: 112 b: 252 range: 255) alpha: 0.3
]

{ #category : #initialization }
ToTextEditorParagraphElement >> defaultTextColor [
	^ Color black
]

{ #category : #drawing }
ToTextEditorParagraphElement >> drawChildrenOnSpartaCanvas: aCanvas [
	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas of: self ]
		during: [
			paragraph
				ifNotNil: [ :aParagraph | aParagraph paintOn: aCanvas at: self padding topLeft ].
			self children sortedByElevation
				do: [ :anElement |
					(anElement isKindOf: BlTextElement)
						ifFalse: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ] ]
]

{ #category : #drawing }
ToTextEditorParagraphElement >> drawSelectionOnSpartaCanvas: aCanvas [
	| aPathBuilder |
	
	selection isEmpty
		ifTrue: [ ^ self ].

	aPathBuilder := aCanvas path.

	selection do: [ :eachMonotoneSelection |		
		(paragraph rectanglesForChars: (eachMonotoneSelection from to: eachMonotoneSelection to)
			width: SkiaParagraphRectWidthStyle Max
			height: SkiaParagraphRectHeightStyle Max) do: [ :eachRectangle |
				aPathBuilder
					moveTo: eachRectangle topLeft;
					lineTo: eachRectangle topRight;
					lineTo: eachRectangle bottomRight;
					lineTo: eachRectangle bottomLeft;
					lineTo: eachRectangle topLeft;
					close ] ].

	aCanvas fill
		path: aPathBuilder build;
		paint: self defaultSelectionColor;
		draw
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> hideCursors [
	self cursorElements do: [ :aCursorElement | aCursorElement visibility: BlVisibility gone ]
]

{ #category : #initialization }
ToTextEditorParagraphElement >> initialize [
	super initialize.

	cursorElements := OrderedCollection new.
	cursorStencil := BrCursorStencil uniqueInstance.
	text := BlText empty.
	selection := BlSelection empty
]

{ #category : #layout }
ToTextEditorParagraphElement >> measureCursors: aCollectionOfCursorElements [
	aCollectionOfCursorElements do: [ :eachCursor |
		| aTextPosition eachCursorRectangle |
		
		aTextPosition := eachCursor textPosition.
		
		eachCursorRectangle := paragraph cursorRectangleForCharacter: aTextPosition.
		eachCursorRectangle := eachCursorRectangle expandBy: 0.5@0.
		eachCursorRectangle := eachCursorRectangle translateBy: ((eachCursorRectangle left min: 0) abs @ 0).
		eachCursorRectangle := eachCursorRectangle translateBy: ((self measuredWidth - eachCursorRectangle right) min: 0) @ 0.

		eachCursor measuredBounds
			extent: eachCursorRectangle extent;
			position: eachCursorRectangle origin + self padding topLeft ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> moveCursorAt: aTextIndex to: aNewPosition [
	"Move a cursor at a given position to a new position"

	^ self
		cursorAt: aTextIndex
		ifFound: [ :aCursorElement |
			aCursorElement textPosition: aNewPosition.
			self requestLayout ]
		ifNone: [ self error: 'Cursor at ', aTextIndex asString, ' does not exist' ]
]

{ #category : #private }
ToTextEditorParagraphElement >> newCursor [
	"Create and return a new instance of a cursor element"
	<return: #BlElement>

	^ self cursorStencil asElement
]

{ #category : #'hooks - children' }
ToTextEditorParagraphElement >> onChildAdded: anElement [
	super onChildAdded: anElement.
	
	(anElement isKindOf: BrCursorElement)
		ifFalse: [ paragraph := nil ]
	
	
]

{ #category : #layout }
ToTextEditorParagraphElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	| placeholders |
	
	placeholders := self placeholderElements.
	placeholders with: paragraph placeholderRectangles do: [ :eachElement :eachBounds |
		eachElement applyLayoutIn: (eachBounds translateBy: self padding topLeft) context: aBlElementBoundsUpdateContext ].
	
	self cursorElements do: [ :eachCursor | eachCursor applyLayoutIn: eachCursor measuredBounds asRectangle context: aBlElementBoundsUpdateContext ].
]

{ #category : #layout }
ToTextEditorParagraphElement >> onMeasure: anExtentMeasurementSpec [
	| aParagraphLayoutWidth |
	self placeholderElements do:  [ :eachElement |
		self layout measureChildWithMargins: eachElement parentSpec: anExtentMeasurementSpec ].

	(paragraph isNil or: [ paragraph isNull ])
		ifTrue: [ self telemetry
				timeSync: 'Build paragraph'
				during: [ paragraph := self buildParagraph ] ].

	aParagraphLayoutWidth := anExtentMeasurementSpec widthSpec isUnspecified
		ifTrue: [ SmallInteger maxVal ]
		ifFalse: [ ((anExtentMeasurementSpec widthSpec size - self padding width) max: 0) ].

	self telemetry
		timeSync: 'Layout paragraph'
		during: [ paragraph layoutWithWidth: aParagraphLayoutWidth ].

	self measuredExtent: (anExtentMeasurementSpec sizeFor: (paragraph longestLine @ paragraph height) + self padding extent).
	
	self telemetry
		timeSync: 'Measure cursors'
		during: [ self cursorElements ifNotEmpty: [ :theCursors | self measureCursors: theCursors ] ]
]

{ #category : #drawing }
ToTextEditorParagraphElement >> paintChildrenOn: aCompositorPainter offset: anOffset [

	paragraph
		ifNotNil: [ :aParagraph |
			aParagraph paintOn: aCompositorPainter canvas at: anOffset + self padding topLeft.
			self paintSelectionOn: aCompositorPainter offset: anOffset + self padding topLeft ].

	aCompositorPainter
		pushChildren: self children sortedByElevation
		offset: anOffset
		compositing: self compositingMode
		thenPaint: [ :aChildElement :aChildPainter :aChildOffset |
			(aChildElement isKindOf: BlTextElement)
				ifFalse: [ aChildElement fullPaintOn: aChildPainter offset: aChildOffset ] ]
]

{ #category : #drawing }
ToTextEditorParagraphElement >> paintSelectionOn: aCompositorPainter offset: anOffset [
	selection isEmpty
		ifTrue: [ ^ self ].

	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [ self drawSelectionOnSpartaCanvas: aCompositorPainter canvas ]
]

{ #category : #accessing }
ToTextEditorParagraphElement >> pieces: aCollectionOfPieces [
	pieces := aCollectionOfPieces.
]

{ #category : #private }
ToTextEditorParagraphElement >> placeholderAndCursorElements [
	^ self children reject: [ :each | (each isKindOf: BlTextElement) ]
]

{ #category : #private }
ToTextEditorParagraphElement >> placeholderElements [
	^ self children reject: [ :each | (each isKindOf: BlTextElement) or: [ each isKindOf: BrCursorElement ] ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> relativeScreenToCursor: aTransformation of: anEditorElement [
	"trying to find a segment that actually contains a given position"
	| aCursor aFocusFinder aDirection aLocalTextPositionOfThisCursor aLocalPositionOfThisCursor aDesiredBounds aScreenPositionOfThisCursor |

	paragraph
		ifNil: [ ^ self ].

	aCursor := aTransformation cursor.
	aLocalTextPositionOfThisCursor := aCursor position - self segment textStart.

	aTransformation isUp
		ifTrue: [
			paragraph
				charOffsetAbove: aLocalTextPositionOfThisCursor
				ifFound: [ :aNewCursorPosition | ^ aTransformation transformed: self segment textStart + aNewCursorPosition ]
				ifNone: [  ] ]
		ifFalse: [ 
			paragraph
				charOffsetBelow: aLocalTextPositionOfThisCursor
				ifFound: [ :aNewCursorPosition | ^ aTransformation transformed: self segment textStart + aNewCursorPosition ]
				ifNone: [  ]	 ].
	
	aDirection := aTransformation isUp
		ifTrue: [ BlFocusSearchDirectionUp new ]
		ifFalse: [ BlFocusSearchDirectionDown new ].

	aLocalPositionOfThisCursor := (paragraph cursorRectangleForCharacter: aLocalTextPositionOfThisCursor) center + self padding topLeft.

	aDesiredBounds := anEditorElement localBoundsToMine: (BlBounds origin: aLocalPositionOfThisCursor extent: 0.0@0.0) fromChild: self.
	aScreenPositionOfThisCursor := aDesiredBounds center.

	aCursor hasDesiredCoordinate
		ifTrue: [ aDesiredBounds translateX: (aCursor desiredCoordinate - aScreenPositionOfThisCursor x) Y: 0 ]
		ifFalse: [ aCursor desiredCoordinate: aScreenPositionOfThisCursor x ].

	aFocusFinder := BlFocusFinder new.
	(aFocusFinder
		root: anEditorElement;
		referenceArea: aDesiredBounds;
		direction: aDirection)
			nextFocusDo: [ :aReceiverElement |
				(aReceiverElement isKindOf: self class)
					ifTrue: [ aReceiverElement screenToCursor: aTransformation of: anEditorElement at: aDesiredBounds center ] ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> removeCursorAt: aTextIndex [
	"Remove cursor at a goven position"

	^ self
		cursorAt: aTextIndex
		ifFound: [ :aCursorElement |
			cursorElements remove: aCursorElement.
			aCursorElement removeFromParent.
			aCursorElement ]
		ifNone: [ self error: 'Cursor at ', aTextIndex asString, ' does not exist' ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> removeCursors [
	"Remove all cursors"

	self cursorElements reverseDo: [ :eachCursorElement | eachCursorElement removeFromParent ].
	self cursorElements removeAll
]

{ #category : #layout }
ToTextEditorParagraphElement >> requestLayout: anElement [
	super requestLayout: anElement.
	
	anElement == self
		ifFalse: [ paragraph := nil ].
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> screenToCursor: aTransformation of: anEditorElement at: aCursorInEditorPosition [
	"trying to find a segment that actually contains a given position"
	| theBoundsInLocal aCharOffsetInParagraph |

	paragraph
		ifNil: [ ^ self ].

	theBoundsInLocal := self
		globalBoundsToMine: (BlBounds origin: aCursorInEditorPosition extent: 0@0)
		fromParent: anEditorElement.
		
	aCharOffsetInParagraph := paragraph
		charOffsetAt: theBoundsInLocal center - self padding topLeft.

	aTransformation transformed: aCharOffsetInParagraph + self segment textStart
]

{ #category : #accessing }
ToTextEditorParagraphElement >> segment [
	^ segment
]

{ #category : #accessing }
ToTextEditorParagraphElement >> segment: anObject [
	segment := anObject
]

{ #category : #accessing }
ToTextEditorParagraphElement >> selection [
	^ selection
]

{ #category : #accessing }
ToTextEditorParagraphElement >> selection: anObject [
	selection := anObject.
	self invalidate
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> setCursors: aCollectionOfCursorPositions [
	<return: #BrCursorElement>
	| theExistingCursors theAddedCursors theRemovedCursors theMovedCursors |
	
	theExistingCursors := self cursorElements collect: [ :eachElement | eachElement textPosition ].
	theAddedCursors := (aCollectionOfCursorPositions difference: theExistingCursors) as: Stack.
	theRemovedCursors := (theExistingCursors difference: aCollectionOfCursorPositions) as: Stack.
	theMovedCursors := OrderedCollection new.
	
	1 to: (theRemovedCursors size min: theAddedCursors size) do: [ :eachIndex |
		theMovedCursors add: (theRemovedCursors pop -> theAddedCursors pop) ].

	theRemovedCursors do: [ :eachToRemove | self removeCursorAt: eachToRemove ].
	theAddedCursors do: [ :eachToAdd | self addCursorAt: eachToAdd ].
	theMovedCursors do: [ :eachAssoc | self moveCursorAt: eachAssoc key to: eachAssoc value ]
]

{ #category : #'api - cursor' }
ToTextEditorParagraphElement >> showCursors [
	self cursorElements do: [ :aCursorElement |
		aCursorElement visibility: BlVisibility visible.
		aCursorElement hasParent
			ifFalse: [ self addChild: aCursorElement ] ]
]

{ #category : #accessing }
ToTextEditorParagraphElement >> text [
	^ text
]

{ #category : #accessing }
ToTextEditorParagraphElement >> text: aBlText [
	text := aBlText
]

{ #category : #private }
ToTextEditorParagraphElement >> textElements [
	^ self children select: [ :each | each isKindOf: BlTextElement ]
]
