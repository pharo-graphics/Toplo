Class {
	#name : #ToTripletLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #alignment }
ToTripletLayoutConstraintsHorizontal >> alignCenter [
	alignment := BlElementAlignment horizontal center
]

{ #category : #alignment }
ToTripletLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : #alignment }
ToTripletLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : #accessing }
ToTripletLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : #accessing }
ToTripletLayoutConstraintsHorizontal >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
ToTripletLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment horizontal start
]
