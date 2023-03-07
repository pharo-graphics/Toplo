Class {
	#name : #ToFTScrollingChanged,
	#superclass : #ToFTAnnouncement,
	#instVars : [
		'newScrollingIndex',
		'oldScrollingIndex'
	],
	#category : #'Toplo-FastTable-Announcement'
}

{ #category : #'instance creation' }
ToFTScrollingChanged class >> from: oldIndex to: newIndex [
	^ self new
		oldScrollingIndex: oldIndex;
		newScrollingIndex: newIndex;
		yourself
]

{ #category : #accessing }
ToFTScrollingChanged >> newScrollingIndex [
	^ newScrollingIndex
]

{ #category : #accessing }
ToFTScrollingChanged >> newScrollingIndex: anObject [
	newScrollingIndex := anObject
]

{ #category : #accessing }
ToFTScrollingChanged >> oldScrollingIndex [
	^ oldScrollingIndex
]

{ #category : #accessing }
ToFTScrollingChanged >> oldScrollingIndex: anObject [
	oldScrollingIndex := anObject
]
