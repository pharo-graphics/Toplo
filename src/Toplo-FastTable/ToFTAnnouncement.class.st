"
I'm a base announcement for FastTable announces.
"
Class {
	#name : #ToFTAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'fastTable'
	],
	#category : #'Toplo-FastTable-Announcement'
}

{ #category : #accessing }
ToFTAnnouncement >> fastTable [
	^ fastTable
]

{ #category : #accessing }
ToFTAnnouncement >> fastTable: aFastTable [
	fastTable := aFastTable
]
