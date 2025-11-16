"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableListElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :header | BlRectangleGeometry new ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :header | BlInsets empty ] ]
]

{ #category : #accessing }
ToTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #accessing }
ToTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray.
	self notifyDataSourceChanged
]

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableNodeManager
]

{ #category : #accessing }
ToTableListElement >> dividerAt: anIndex movedBy: aDistance from: aStartLocation [

	self innerElement nodes do: [ :n |
		n dividerAt: anIndex movedBy: aDistance from: aStartLocation ]
]

{ #category : #initialization }
ToTableListElement >> freezeColumnsWidth [

	self innerElement nodesDo: [ :n | n freezeColumnsWidth ]
]
