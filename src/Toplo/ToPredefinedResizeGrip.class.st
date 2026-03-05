Class {
	#name : #ToPredefinedResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToPredefinedResizeGrip class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: #geometry asWritableProperty
				with: [ :e |
						BlRoundedRectangleGeometry cornerRadius:
							(e valueOfTokenNamed: #'window-corner-grips-size') ].
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
ToPredefinedResizeGrip >> cursorSelector [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToPredefinedResizeGrip >> resizeCursor [

	^ Cursor perform: self cursorSelector
]
