Class {
	#name : #ToImplicitState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToImplicitState >> lookEvent [

	^ self newLookEvent 
]

{ #category : #accessing }
ToImplicitState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToImplicitState >> newLookEvent [

	^ self lookEventClass new
		  fromState: self;
		  yourself
]
