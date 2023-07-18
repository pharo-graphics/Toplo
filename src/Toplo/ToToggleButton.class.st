Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'#onElement',
		'#offElement'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultSkin [

	^ ToToggleSkin new
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self initializeCheckable
]

{ #category : #accessing }
ToToggleButton >> newTrackElement [

	^ ToToggleTrackElement new
		  onElement: self onElement;
		  offElement: self offElement;
		  yourself
]

{ #category : #accessing }
ToToggleButton >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleButton >> offElement: anElement [

	offElement := anElement
]

{ #category : #accessing }
ToToggleButton >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleButton >> onElement: anElement [

	onElement := anElement
]

{ #category : #accessing }
ToToggleButton >> track [

	^ self icon
]

{ #category : #accessing }
ToToggleButton >> track: anElement [

	self icon: anElement
]
