"
I announce a strong selection happened (this is a double-click)

Description
-------------------

I store the index of the row and the event (doubleClick) the ToFTTableMorph received.
I should be use by the user to defined an action to execute when a DoubleClic happen on a Table.

Public API and Key Messages
-------------------

- #rowIndex: anIndex event: anEvent 		is the commun constructor.
 
Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	event:		An event received by the ToFTTableMorph.
	selectedRowIndex:		The index of the row in the table that was selected. 

			
From the index you can get an object from the ToFTTableMorph with: 

aToFTTableMorph dataSource elementAt: selectedRowIndex  

"
Class {
	#name : #ToFTStrongSelectionChanged,
	#superclass : #ToFTAnnouncement,
	#instVars : [
		'event',
		'selectedIndex'
	],
	#category : #'Toplo-FastTable-Announcement'
}

{ #category : #'instance creation' }
ToFTStrongSelectionChanged class >> index: aNumber event: anEvent [
	^ self new
		selectedIndex: aNumber;
		event: anEvent;
		yourself
]

{ #category : #accessing }
ToFTStrongSelectionChanged >> event [
	^ event
]

{ #category : #accessing }
ToFTStrongSelectionChanged >> event: anEvent [
	event := anEvent
]

{ #category : #accessing }
ToFTStrongSelectionChanged >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
ToFTStrongSelectionChanged >> selectedIndex: anObject [
	selectedIndex := anObject
]

{ #category : #accessing }
ToFTStrongSelectionChanged >> selectedRowIndex [
	self deprecated: 'Use #selectedIndex instead' transformWith: '`@receiver selectedRowIndex' -> '`@receiver selectedIndex'.
	^ self selectedIndex
]
