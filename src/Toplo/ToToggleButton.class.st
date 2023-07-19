Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToCheckableButtonDresser new
]

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultSkin [

	^ ToToggleSkin new
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self initializeCheckable.
	self track: ToToggleTrackElement new
	
]

{ #category : #accessing }
ToToggleButton >> switchBarOffElement [

	^ self track switchBarOffElement
]

{ #category : #accessing }
ToToggleButton >> switchBarOffElement: anElement [

	self track switchBarOffElement: anElement
]

{ #category : #accessing }
ToToggleButton >> switchBarOnElement [

	^ self track switchBarOnElement
]

{ #category : #accessing }
ToToggleButton >> switchBarOnElement: anElement [

	self track switchBarOnElement: anElement
]

{ #category : #accessing }
ToToggleButton >> switchButton [

	^ self track switchButton
]

{ #category : #accessing }
ToToggleButton >> switchButtonOffElement [

	^ self track switchButtonOffElement
]

{ #category : #accessing }
ToToggleButton >> switchButtonOffElement: anElement [

	^ self track switchButtonOffElement: anElement
]

{ #category : #accessing }
ToToggleButton >> switchButtonOnElement: anElement [

	self track switchButtonOnElement: anElement
]

{ #category : #accessing }
ToToggleButton >> track [

	^ self icon
]

{ #category : #accessing }
ToToggleButton >> track: anElement [

	self icon: anElement
]
