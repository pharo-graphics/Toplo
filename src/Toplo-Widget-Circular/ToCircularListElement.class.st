Class {
	#name : #ToCircularListElement,
	#superclass : #ToBasicCircularElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#instVars : [
		'selectionUpdateRequested'
	],
	#category : #'Toplo-Widget-Circular-BasicElement'
}

{ #category : #'t - inner finite list element - requirements' }
ToCircularListElement >> addNodeContainer: aNodeContainer at: aPosition [

	self addChild: aNodeContainer at: aPosition.
	self requestUpdateAllSelections
]

{ #category : #'private - scrolling' }
ToCircularListElement >> angularDeltaFromWheelEvent: evt [ 
    | inSpacecenter radial cross wheel  |

    inSpacecenter := self bounds inSpace center.

    "Screen → math coordinates (Y inverted)"
    radial := evt position - inSpacecenter.
    radial := radial x @ radial y negated.
    radial isZero ifTrue: [ ^ 0 ].
    radial := radial normalized.

    wheel := evt vector x @ evt vector y negated.

    "2D vector * "
    cross :=
        (radial x * wheel y)
        - (radial y * wheel x).

    ^ cross * scrollSensitivity 
]

{ #category : #configuration }
ToCircularListElement >> applyConfiguration [

	super applyConfiguration.
	self applyInnerFiniteListElementConfiguration 
]

{ #category : #'selection updating' }
ToCircularListElement >> forceUpdateAllSelections [

	listElement ifNil: [ ^ self ].
	listElement forceUpdateAllSelections.
	listElement requestMouseMoveReplay
]

{ #category : #initialization }
ToCircularListElement >> initialize [ 

	super initialize.
	self initializeAsToInnerFiniteElement.
	self addEventHandler: ToScrollableElementEventHandler new.
	selectionUpdateRequested := false

]

{ #category : #scrolling }
ToCircularListElement >> mouseWheelEvent: anEvent [
	"Instant scroll by the given amount of pixels along either axis.
	Return true if a scroll happens."
	<return: #Boolean>

	self startAngle:
		self startAngle + (self angularDeltaFromWheelEvent: anEvent).
	self requestUpdateAllSelections.
	^ true
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainers [

	^ self children
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainersDo: aBlock [

	self childrenDo: aBlock
]

{ #category : #'hooks - layout' }
ToCircularListElement >> onLayoutDone [

	super onLayoutDone.
	self consumeFinalStepCommands.
	selectionUpdateRequested ifFalse: [ ^ self ].
	self forceUpdateAllSelections.
	selectionUpdateRequested := false
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock 
]

{ #category : #'t - inner finite list element - requirements' }
ToCircularListElement >> removeNodeContainer: aNodeContainer [

	aNodeContainer removeFromParent.
	self requestUpdateAllSelections
]

{ #category : #'selection updating' }
ToCircularListElement >> requestUpdateAllSelections [

	selectionUpdateRequested := true
]

{ #category : #scrolling }
ToCircularListElement >> scrollBy: aPoint [
	"Instant scroll by the given amount of pixels along either axis.
	Return true if a scroll happens."
	<return: #Boolean>
	" nothing to do here, see `mouseWheelEvent:`"
	^ true
]
