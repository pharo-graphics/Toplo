"
I announce a selection change (usually a click, but can also be done with arrows up and down).

Description
-------------------

I store the old selected rows and the new selected row. 
I should be use to act with the user when he interact with a Fast Table.

Public API and Key Messages
-------------------

- #from: arrayOfIndexes to: arrayOfIndexes 		is the commun constructor.
 
Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	newSelectedRowIndexes:		An array of indexes that store the new selection.
	oldSelectedRowIndexes:		An array of indexes that store the old selection.
			
From the index you can get an object from the ToFTTableMorph with: 

aToFTTableMorph dataSource elementAt: selectedRowIndex 
"
Class {
	#name : #ToFTSelectionChanged,
	#superclass : #ToFTAnnouncement,
	#instVars : [
		'newSelectedIndexes',
		'oldSelectedIndexes'
	],
	#category : #'Toplo-FastTable-Announcement'
}

{ #category : #'instance creation' }
ToFTSelectionChanged class >> from: oldArray to: newArray [
	^ self new
		oldSelectedIndexes: oldArray;
		newSelectedIndexes: newArray;
		yourself
]

{ #category : #accessing }
ToFTSelectionChanged >> newSelectedIndexes [
	^ newSelectedIndexes
]

{ #category : #accessing }
ToFTSelectionChanged >> newSelectedIndexes: anObject [
	newSelectedIndexes := anObject
]

{ #category : #accessing }
ToFTSelectionChanged >> oldSelectedIndexes [
	^ oldSelectedIndexes
]

{ #category : #accessing }
ToFTSelectionChanged >> oldSelectedIndexes: anObject [
	oldSelectedIndexes := anObject
]
