Class {
	#name : #ToInstallStateEvent,
	#superclass : #ToElementStateEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToInstallStateEvent >> sendToLook: aLook [

	aLook installStateEvent: self
]
