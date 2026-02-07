Class {
	#name : #ToAnnulusCircularElement,
	#superclass : #ToBasicCircularElement,
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #initialization }
ToAnnulusCircularElement >> defaultLayout [ 

	^ ToAnnulusCircularLayout new
]

{ #category : #accessing }
ToAnnulusCircularElement >> innerRadius [

	^ layout innerRadius
]

{ #category : #accessing }
ToAnnulusCircularElement >> innerRadius: aFloat [

	(self innerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout innerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularElement >> outerRadius [

	^ layout outerRadius
]

{ #category : #accessing }
ToAnnulusCircularElement >> outerRadius: aFloat [

	(self outerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout outerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusCircularElement >> uniformSectors [

	^ layout uniformSectors
]

{ #category : #accessing }
ToAnnulusCircularElement >> uniformSectors: aBoolean [

	self uniformSectors = aBoolean ifTrue: [ ^ self ].
	layout uniformSectors: aBoolean.
	self requestLayout
]
