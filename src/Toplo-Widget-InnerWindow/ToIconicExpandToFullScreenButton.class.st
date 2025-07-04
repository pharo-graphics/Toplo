Class {
	#name : #ToIconicExpandToFullScreenButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #initialization }
ToIconicExpandToFullScreenButton >> initialize [ 

	super initialize.
	self id: #'expand-iconic-button'
]

{ #category : #'instance creation' }
ToIconicExpandToFullScreenButton >> newRawSkin [ 

	^ ToIconicExpandToFullScreenButtonSkin new
]
