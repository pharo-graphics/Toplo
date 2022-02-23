Class {
	#name : #TcBasicWidget,
	#superclass : #TcWidget,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#category : #'Toploc-Widgets'
}

{ #category : #initialization }
TcBasicWidget >> initialize [
	self class initializeSlots: self.
	super initialize.

]

{ #category : #accessing }
TcBasicWidget >> model [

	^ self 
	
]
