Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToWidget >> defaultBackground [
	^ Color transparent
]

{ #category : #initialization }
ToWidget >> initialize [

	super initialize.
	self background: self defaultBackground
]
