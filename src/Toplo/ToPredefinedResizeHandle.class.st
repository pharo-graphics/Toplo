Class {
	#name : #ToPredefinedResizeHandle,
	#superclass : #ToHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #initialization }
ToPredefinedResizeHandle class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToHoveredSkinEvent
				write: #border asWritableProperty
				with: [ :e | BlBorder paint: (Color lightGray alpha: 0.2) ].
			aTheme
				when: ToDragEndedSkinEvent
				write: #border asWritableProperty
				with: [ :e | BlBorder empty ].
			aTheme
				when: ToLeftSkinEvent
				write: #border asWritableProperty
				with: [ :e | BlBorder empty ].
			aTheme
				when: ToHoveredSkinEvent
				write: #background asWritableProperty
				with: [ :e | Color lightGray alpha: 0.2 ].
			aTheme
				when: ToDragEndedSkinEvent
				write: #background asWritableProperty
				with: [ :e | Color transparent ].
			aTheme
				when: ToLeftSkinEvent
				write: #background asWritableProperty
				with: [ :e | Color transparent ] ]
]

{ #category : #accessing }
ToPredefinedResizeHandle >> cursorSelector [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToPredefinedResizeHandle >> handleCursor [

	^ Cursor perform: self cursorSelector
]

{ #category : #configuration }
ToPredefinedResizeHandle >> prepareConfiguration [

	super prepareConfiguration.
	self constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors removeAll ]
]
