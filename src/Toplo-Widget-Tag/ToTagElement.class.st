Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToColorableItemElement',
	#classTraits : 'TToColorableItemElement classTrait',
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #initialization }
ToTagElement >> initialize [ 

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self takeFocusOnClick: false
]

{ #category : #'t - checkable  - protocol' }
ToTagElement >> initializeAsCheckable [ 

	super initializeAsCheckable.
	self takeFocusOnClick: true
]

{ #category : #skin }
ToTagElement >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToCheckableTagSkin new ]
		  ifFalse: [ ToTagElementSkin new ]
]
