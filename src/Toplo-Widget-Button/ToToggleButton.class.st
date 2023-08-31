Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser next: ToTripletDresser new
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self initializeCheckable.
	self track: (ToToggleTrackElement new checked: self isChecked; yourself)
]

{ #category : #accessing }
ToToggleButton >> innerButton [

	^ self track innerButton
]

{ #category : #accessing }
ToToggleButton >> switchBarOffContainer [

	^ self track switchBarOffContainer
]

{ #category : #accessing }
ToToggleButton >> switchBarOffElement: anElement [

	self track switchBarOffElement: anElement
]

{ #category : #accessing }
ToToggleButton >> switchBarOnContainer [

	^ self track switchBarOnContainer
]

{ #category : #accessing }
ToToggleButton >> switchBarOnElement: anElement [

	self track switchBarOnElement: anElement
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
ToToggleButton >> switchButtonOnElement [

	^ self track switchButtonOnElement
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
