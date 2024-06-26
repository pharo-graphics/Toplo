Class {
	#name : #ToImplicitState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToImplicitState >> newSkinEvent [

	^ self skinEventClass new
		  fromState: self;
		  yourself
]

{ #category : #accessing }
ToImplicitState >> skinEvent [

	^ self newSkinEvent 
]

{ #category : #accessing }
ToImplicitState >> skinEventClass [

	^ self subclassResponsibility 
]
