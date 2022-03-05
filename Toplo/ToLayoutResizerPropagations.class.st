Class {
	#name : #ToLayoutResizerPropagations,
	#superclass : #Object,
	#instVars : [
		'propagations',
		'propagationMap'
	],
	#category : #'Toplo-Core-Layout Resizer'
}

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hAll [
	^ { self hFitContent . self hFitContentLimited . self hExact . self hMatchParent }
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hExact [
	^ BrLayoutHorizontalResizerState exact
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hExact: aWidth [
	^ BrLayoutHorizontalExactResizerPropagatedState new width: aWidth
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hFitContent [
	^ BrLayoutHorizontalResizerState fitContent
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hFitContentLimited [
	^ BrLayoutHorizontalResizerState fitContentLimited
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> hMatchParent [
	^ BrLayoutHorizontalResizerState matchParent
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> vAll [
	^ { self vFitContent . self vFitContentLimited . self vExact . self vMatchParent }
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> vExact [
	^ BrLayoutVerticalResizerState exact
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> vFitContent [
	^ BrLayoutVerticalResizerState fitContent
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> vFitContentLimited [
	^ BrLayoutVerticalResizerState fitContentLimited
]

{ #category : #'api - layout resizeable' }
ToLayoutResizerPropagations class >> vMatchParent [
	^ BrLayoutVerticalResizerState matchParent
]

{ #category : #'adding / removing' }
ToLayoutResizerPropagations >> addPropagation: aBrLayoutResizerPropagation [
	propagations add: aBrLayoutResizerPropagation
]

{ #category : #'private - insance creation' }
ToLayoutResizerPropagations >> addPropagationFor: aChildOrCollectionOrBlock [
	<return: #BrLayoutResizerPropagation>
	| aPropagation |

	self addPropagation: (aPropagation := self newPropagationFor: aChildOrCollectionOrBlock).
	^ aPropagation
]

{ #category : #'adding / removing' }
ToLayoutResizerPropagations >> addPropagations: aBrLayoutResizerPropagations [
	propagations addAll: aBrLayoutResizerPropagations
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> anyToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class hAll
			to: self class hFitContent;
		fromAll: self class vAll
			to: self class vFitContent
]

{ #category : #accessing }
ToLayoutResizerPropagations >> clearPropagationRules: aParentElement [
	propagationMap removeAll
]

{ #category : #accessing }
ToLayoutResizerPropagations >> do: aBlock [
	propagations do: aBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> exactToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
			to: self class hMatchParent;
		from: self class vExact
			to: self class vMatchParent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> fitContentLimitedToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContentLimited
			to: self class hFitContentLimited;
		from: self class vFitContentLimited
			to: self class vFitContentLimited
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> fitContentToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContent
			to: self class hFitContent;
		from: self class vFitContent
			to: self class vFitContent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> hAnyToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class hAll
		to: self class hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> hAnyToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class hAll
		to: self class hFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hAnyToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class hAll
		to: self class hMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> hExactToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
		to: self class hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> hExactToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
		to: self class hFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hExactToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
		to: self class hMatchParent
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hFitContent: aChildElementOrBlock toExact: aWidth [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContent
		to: (self class hExact: aWidth)
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> hFitContentLimitedToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContentLimited
		to: self class hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> hFitContentLimitedToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContentLimited
		to: self class hFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hFitContentLimitedToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContentLimited
		to: self class hMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> hFitContentToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContent
		to: self class hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> hFitContentToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContent
		to: self class hFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hFitContentToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContent
		to: self class hMatchParent
]

{ #category : #'api - inherit' }
ToLayoutResizerPropagations >> hInherit: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
			to: self class hMatchParent;
		from: self class hFitContent
			to: self class hFitContent;
		from: self class hFitContentLimited
			to: self class hFitContentLimited;
		from: self class hMatchParent
			to: self class hMatchParent
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hMatchParent: aChildElementOrBlock toExact: aWidth [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hMatchParent
		to: (self class hExact: aWidth)
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> hMatchParentToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hMatchParent
		to: self class hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> hMatchParentToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hFitContentLimited
		to: self class hFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> hMatchParentToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hMatchParent
		to: self class hMatchParent
]

{ #category : #'api - inherit' }
ToLayoutResizerPropagations >> inherit: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hExact
			to: self class hMatchParent;
		from: self class hFitContent
			to: self class hFitContent;
		from: self class hFitContentLimited
			to: self class hFitContentLimited;
		from: self class hMatchParent
			to: self class hMatchParent;
		from: self class vExact
			to: self class vMatchParent;
		from: self class vFitContent
			to: self class vFitContent;
		from: self class vFitContentLimited
			to: self class vFitContentLimited;
		from: self class vMatchParent
			to: self class vMatchParent
]

{ #category : #initialization }
ToLayoutResizerPropagations >> initialize [
	super initialize.
	
	propagations := OrderedCollection new.
	propagationMap := IdentityDictionary new
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> matchParentToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class hMatchParent
			to: self class hMatchParent;
		from: self class vMatchParent
			to: self class vMatchParent
]

{ #category : #'private - insance creation' }
ToLayoutResizerPropagations >> newPropagationFor: aChildOrCollectionOrBlock [
	<return: #BrLayoutResizerPropagation>

	aChildOrCollectionOrBlock isBlock
		ifTrue: [ ^ BrLayoutResizerDynamicPropagation new childrenBlock: aChildOrCollectionOrBlock ].

	aChildOrCollectionOrBlock isCollection
		ifTrue: [ ^ BrLayoutResizerChildrenPropagation new childrenElements: aChildOrCollectionOrBlock ].

	(aChildOrCollectionOrBlock respondsTo: #asBlocElementId)
		ifTrue: [ ^ BrLayoutResizerChildByIdPropagation new childId: aChildOrCollectionOrBlock ].

	^ BrLayoutResizerChildPropagation new childElement: aChildOrCollectionOrBlock
]

{ #category : #accessing }
ToLayoutResizerPropagations >> precomputePropagationRules: aParentElement [
	propagationMap
		ifNotEmpty: [ ^ self ].

	propagationMap removeAll.

	propagations do: [ :eachPropagation |
		eachPropagation
			childrenToPropagateFrom: aParentElement
			do: [ :eachChildElement |
				| eachPropagationMap |

				eachPropagationMap := propagationMap
					at: eachChildElement
					ifAbsentPut: [ Dictionary new ].
					
				eachPropagation propagationAssociations do: [ :eachAssociation |
					eachPropagationMap at: eachAssociation key put: eachAssociation value ] ] ]
]

{ #category : #accessing }
ToLayoutResizerPropagations >> propagateState: aBrLayoutResizerState from: aParentElement to: aChildElement [

	^ propagationMap
		at: aChildElement
		ifPresent: [ :aPropagationMap |
			aPropagationMap
				at: aBrLayoutResizerState asNotPropagated
				ifPresent: [ :aMappedState | aMappedState asPropagated ]
				ifAbsent: [ aBrLayoutResizerState asNotPropagated ] ]
		ifAbsent: [ aBrLayoutResizerState asNotPropagated ]
]

{ #category : #'adding / removing' }
ToLayoutResizerPropagations >> removePropagation: aBrLayoutResizerPropagation [
	propagations remove: aBrLayoutResizerPropagation ifAbsent: [  ]
]

{ #category : #'adding / removing' }
ToLayoutResizerPropagations >> removePropagations: aBrLayoutResizerPropagations [
	propagations removeAll: aBrLayoutResizerPropagations
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> vAnyToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class vAll
		to: self class vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> vAnyToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class vAll
		to: self class vFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> vAnyToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		fromAll: self class vAll
		to: self class vMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> vExactToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vExact
		to: self class vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> vExactToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vExact
		to: self class vFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> vExactToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vExact
		to: self class vMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> vFitContentLimitedToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContentLimited
		to: self class vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> vFitContentLimitedToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContentLimited
		to: self class vFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> vFitContentLimitedToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContentLimited
		to: self class vMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> vFitContentToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContent
		to: self class vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> vFitContentToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContent
		to: self class vFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> vFitContentToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContent
		to: self class vMatchParent
]

{ #category : #'api - inherit' }
ToLayoutResizerPropagations >> vInherit: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vExact
			to: self class vMatchParent;
		from: self class vFitContent
			to: self class vFitContent;
		from: self class vFitContentLimited
			to: self class vFitContentLimited;
		from: self class vMatchParent
			to: self class vMatchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerPropagations >> vMatchParentToFitContent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vMatchParent
		to: self class vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerPropagations >> vMatchParentToFitContentLimited: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vFitContentLimited
		to: self class vFitContentLimited
]

{ #category : #'api - to match parent' }
ToLayoutResizerPropagations >> vMatchParentToMatchParent: aChildElementOrBlock [
	(self addPropagationFor: aChildElementOrBlock)
		from: self class vMatchParent
		to: self class vMatchParent
]
