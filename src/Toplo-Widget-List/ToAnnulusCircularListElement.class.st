Class {
	#name : #ToAnnulusCircularListElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #initialization }
ToAnnulusCircularListElement >> defaultLayout [ 

	^ ToAnnulusCircularLayout new
]

{ #category : #accessing }
ToAnnulusCircularListElement >> innerRadius [

	^ layout innerRadius
]

{ #category : #accessing }
ToAnnulusCircularListElement >> innerRadius: aFloat [

	(self innerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout innerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularListElement >> outerRadius [

	^ layout outerRadius
]

{ #category : #accessing }
ToAnnulusCircularListElement >> outerRadius: aFloat [

	(self outerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout outerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularListElement >> startAngle [

	^ layout startAngle
]

{ #category : #accessing }
ToAnnulusCircularListElement >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngle: anAngleInDegrees.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularListElement >> startAngleOffset [

	^ layout startAngleOffset
]

{ #category : #accessing }
ToAnnulusCircularListElement >> startAngleOffset: anAngleInDegrees [

	(self startAngleOffset closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngleOffset: anAngleInDegrees.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularListElement >> uniformSectors [

	^ layout uniformSectors
]

{ #category : #accessing }
ToAnnulusCircularListElement >> uniformSectors: aBoolean [

	self uniformSectors = aBoolean ifTrue: [ ^ self ].
	layout uniformSectors: aBoolean.
	self requestLayout
]
