Class {
	#name : #ToLayoutResizerAptitude,
	#superclass : #BrStyleAptitude,
	#instVars : [
		'propagations'
	],
	#category : #'Toplo-Core-Layout Resizer'
}

{ #category : #'api - style' }
ToLayoutResizerAptitude class >> inherit [
	^ self new inherit
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> anyToFitContent [
	"Always fit content irrelevant from what model says"

	self
		hAnyToFitContent;
		vAnyToFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> anyToFitContent: aChildElementOrBlock [
	"Always fit content vertically and horizontally irrelevant from what model says"

	propagations anyToFitContent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> exactDo: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalResizerState exact and: BrLayoutVerticalResizerState exact))
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> exactToFitContent [
	self hExactToFitContent.
	self vExactToFitContent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> exactToMatchParent: aChildElementOrBlock [
	propagations exactToMatchParent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> fitContentDo: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalResizerState fitContent and: BrLayoutVerticalResizerState fitContent))
]

{ #category : #'api - to fit content limited element' }
ToLayoutResizerAptitude >> fitContentLimitedToFitContentLimited: aChildElementOrBlock [
	"Inherit fit content limited in both directions if model says so"
		
	propagations fitContentLimitedToFitContentLimited: aChildElementOrBlock
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> fitContentToFitContent [
	self hFitContentToFitContent.
	self vFitContentToFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> fitContentToFitContent: aChildElementOrBlock [
	"Inherit fit content in both directions if model says so"
	
	propagations fitContentToFitContent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hAny [
	^ self styleFor: BrLayoutHorizontalResizerState any
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> hAnyToFitContent [
	"Always fit content horizontally irrelevant from what model says"

	self hAny hFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> hAnyToFitContent: aChildElementOrBlock [
	"Always fit content horizontally irrelevant from what model says"

	propagations hAnyToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> hAnyToMatchParent [
	"Always match parent horizontally irrelevant from what model says"

	self hAny hMatchParent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> hAnyToMatchParent: aChildElementOrBlock [
	"Match parent horizontally"

	propagations hAnyToMatchParent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hExact [
	^ self styleFor: BrLayoutHorizontalResizerState exact
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hExactDo: aBlock [
	aBlock value: self hExact
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> hExactToFitContent [
	"Fit content if model specifies exact size horizontally"

	self hExact hFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> hExactToFitContent: aChildElementOrBlock [
	"Fit content horizontally if model says to be exact size"	

	propagations hExactToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> hExactToMatchParent [
	"Match parent if model specifies exact size horizontally"

	self hExact hMatchParent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> hExactToMatchParent: aChildElementOrBlock [
	"Match parent if model specifies exact size horizontally"

	propagations hExactToMatchParent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hFitContent [
	^ self styleFor: BrLayoutHorizontalResizerState fitContent
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hFitContentLimited [
	^ self styleFor: BrLayoutHorizontalResizerState fitContentLimited
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> hFitContentLimitedToFitContent [
	"Fit content if model specifies fit content limited horizontally"

	self hFitContentLimited hFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerAptitude >> hFitContentLimitedToFitContentLimited [
	"Inherit fit content limited horizontally if model says so"

	self hFitContentLimited hFitContentLimited
]

{ #category : #'api - to fit content limited element' }
ToLayoutResizerAptitude >> hFitContentLimitedToFitContentLimited: aChildElementOrBlock [
	"Inherit fit content limited horizontally if model says so"

	propagations hFitContentLimitedToFitContentLimited: aChildElementOrBlock
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> hFitContentToFitContent [
	"Inherit fit content horizontally if model says so"

	self hFitContent hFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> hFitContentToFitContent: aChildElementOrBlock [
	"Inherit fit content horizontally if model says so"
		
	propagations hFitContentToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> hFitContentToMatchParent [
	"Match parent if model specifies fit content horizontally"

	self hFitContent hMatchParent
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> hInherit [
	self
		hMatchParentToMatchParent;
		hFitContentToFitContent;
		hFitContentLimitedToFitContentLimited
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> hInherit: aChildElementOrBlock [
	propagations hInherit: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> hMatchParent [
	^ self styleFor: BrLayoutHorizontalResizerState matchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> hMatchParentToFitContent [
	"Fit content if model specifies match parent parent horizontally"

	self hMatchParent hFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> hMatchParentToFitContent: aChildElementOrBlock [
	"Fit content horizontally if model says match parent"

	propagations hMatchParentToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> hMatchParentToMatchParent [
	"Inherit match parent horizontally if model says so"

	self hMatchParent hMatchParent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> hMatchParentToMatchParent: aChildElementOrBlock [
	"Match parent if model specifies match parent horizontally"

	propagations hMatchParentToMatchParent: aChildElementOrBlock
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> inherit [
	self hInherit.
	self vInherit.
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> inherit: aChildElementOrBlock [
	propagations inherit: aChildElementOrBlock
]

{ #category : #initialization }
ToLayoutResizerAptitude >> initialize [
	super initialize.

	propagations := ToLayoutResizerPropagations new.

	self addChange:
		(BrLookChange new
			up: [ :thisLook | thisLook widget layoutResizerPropagations addPropagations: propagations ];
			down: [ :thisLook | thisLook widget layoutResizerPropagations removePropagations: propagations ];
			yourself)
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> matchParentDo: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalResizerState matchParent and: BrLayoutVerticalResizerState matchParent))
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> matchParentToMatchParent: aChildElementOrBlock [
	"Match parent if model specifies match parent in both dimensions"

	propagations matchParentToMatchParent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vAny [
	^ self styleFor: BrLayoutVerticalResizerState any
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> vAnyToFitContent [
	"Always fit content vertically irrelevant from what model says"

	self vAny vFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> vAnyToFitContent: aChildElementOrBlock [
	"Always fit content vertically irrelevant from what model says"

	propagations vAnyToFitContent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vExact [
	^ self styleFor: BrLayoutVerticalResizerState exact
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vExactDo: aBlock [
	aBlock value: self vExact
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> vExactToFitContent [
	"Fit content if model specifies exact size vertically"

	self vExact vFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> vExactToFitContent: aChildElementOrBlock [
	"Fit content vertically if model says to be exact size"	

	propagations vExactToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> vExactToMatchParent [
	"Match parent if model specifies exact size vertically"

	self vExact vMatchParent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> vExactToMatchParent: aChildElementOrBlock [
	"Match parent if model specifies exact size horizontally"

	propagations vExactToMatchParent: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vFitContent [
	^ self styleFor: BrLayoutVerticalResizerState fitContent
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vFitContentLimited [
	^ self styleFor: BrLayoutVerticalResizerState fitContentLimited
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> vFitContentLimitedToFitContent [
	"Fit content if model specifies fit content limited vertically"

	self vFitContentLimited vFitContent
]

{ #category : #'api - to fit content limited' }
ToLayoutResizerAptitude >> vFitContentLimitedToFitContentLimited [
	"Inherit fit content limited horizontally if model says so"

	self vFitContentLimited vFitContentLimited
]

{ #category : #'api - to fit content limited element' }
ToLayoutResizerAptitude >> vFitContentLimitedToFitContentLimited: aChildElementOrBlock [
	"Inherit fit content limited vertically if model says so"
		
	propagations vFitContentLimitedToFitContentLimited: aChildElementOrBlock
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> vFitContentToFitContent [
	"Fit content if model specifies fit content vertically"

	self vFitContent vFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> vFitContentToFitContent: aChildElementOrBlock [
	"Inherit fit content vertically if model says so"
		
	propagations vFitContentToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> vFitContentToMatchParent [
	"Match parent if model specifies fit content vertically"

	self vFitContent vMatchParent
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> vInherit [
	self
		vMatchParentToMatchParent;
		vFitContentToFitContent;
		vFitContentLimitedToFitContentLimited
]

{ #category : #'api - inherit' }
ToLayoutResizerAptitude >> vInherit: aChildElementOrBlock [
	propagations vInherit: aChildElementOrBlock
]

{ #category : #'api - style' }
ToLayoutResizerAptitude >> vMatchParent [
	^ self styleFor: BrLayoutVerticalResizerState matchParent
]

{ #category : #'api - to fit content' }
ToLayoutResizerAptitude >> vMatchParentToFitContent [
	"Fit content if model specifies match parent parent vertically"

	self vMatchParent vFitContent
]

{ #category : #'api - to fit content element' }
ToLayoutResizerAptitude >> vMatchParentToFitContent: aChildElementOrBlock [
	"Fit content vertically if model says match parent"
	
	propagations vMatchParentToFitContent: aChildElementOrBlock
]

{ #category : #'api - to match parent' }
ToLayoutResizerAptitude >> vMatchParentToMatchParent [
	"Inherit match parent vertical if model says so"

	self vMatchParent vMatchParent
]

{ #category : #'api - to match parent element' }
ToLayoutResizerAptitude >> vMatchParentToMatchParent: aChildElementOrBlock [
	"Match parent if model specifies match parent vertically"

	propagations vMatchParentToMatchParent: aChildElementOrBlock
]
