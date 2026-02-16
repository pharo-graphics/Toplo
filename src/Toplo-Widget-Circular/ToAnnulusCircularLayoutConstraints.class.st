Class {
	#name : #ToAnnulusCircularLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'angleGap',
		'angleWeight'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> angleGap [

	^ angleGap 
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> angleGap: anObject [

	angleGap := anObject
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> angleWeight [

	^ angleWeight
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> angleWeight: anObject [

	angleWeight := anObject
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> expliciteAngleGap [

	^ angleGap ifNil: [
		  angleWeight ifNotNil: [ :w | 360 * w ] ifNil: [ 0 ] ]
]
