Class {
	#name : #ToCheckableGroupChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'checkedButtons',
		'uncheckedButtons'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToCheckableGroupChangedAnnouncement >> checkedButtons [

	^ checkedButtons
]

{ #category : #accessing }
ToCheckableGroupChangedAnnouncement >> checkedButtons: anObject [

	checkedButtons := anObject
]

{ #category : #accessing }
ToCheckableGroupChangedAnnouncement >> uncheckedButtons [

	^ uncheckedButtons
]

{ #category : #accessing }
ToCheckableGroupChangedAnnouncement >> uncheckedButtons: anObject [

	uncheckedButtons := anObject
]
