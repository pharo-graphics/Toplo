Class {
	#name : #ToTripletLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #alignment }
ToTripletLayoutConstraintsVertical >> alignBottom [
	alignment := BlElementAlignment vertical end
]

{ #category : #alignment }
ToTripletLayoutConstraintsVertical >> alignCenter [
	alignment := BlElementAlignment vertical center
]

{ #category : #alignment }
ToTripletLayoutConstraintsVertical >> alignTop [
	alignment := BlElementAlignment vertical start
]

{ #category : #accessing }
ToTripletLayoutConstraintsVertical >> alignment [
	^ alignment
]

{ #category : #accessing }
ToTripletLayoutConstraintsVertical >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
ToTripletLayoutConstraintsVertical >> initialize [
	super initialize.
	
	alignment := BlElementAlignment vertical start
]
