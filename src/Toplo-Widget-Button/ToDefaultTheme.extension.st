Extension { #name : #ToDefaultTheme }

{ #category : #'*Toplo-Widget-Button' }
ToDefaultTheme >> checkboxCheckedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   border: (BlBorder paint: anElement toTheme colorPrimary width: 6);
			   margin: (BlInsets all: 0);
			   background: anElement toTheme colorBgContainer;
			   yourself)
]

{ #category : #'*Toplo-Widget-Button' }
ToDefaultTheme >> checkboxDisabledImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   border: (BlBorder paint: anElement toTheme colorBorderDisabled width: 6);
			   margin: (BlInsets all: 0);
			   background: anElement toTheme colorBgContainer;
			   yourself)
]

{ #category : #'*Toplo-Widget-Button' }
ToDefaultTheme >> checkboxIndeterminateImageIn: anElement [

	| bar im |
	bar := BlElement new
		       constraintsDo: [ :c |
			       c horizontal matchParent.
			       c vertical exact: 4.
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ];
		       border: BlBorder empty;
		       background: anElement toTheme colorPrimary.
	im := BlElement new
		      size: 12 @ 12;
		      margin: (BlInsets all: 2);
				background: (anElement toTheme colorBgContainer alpha: 0);
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: bar.
	^ ToImage inner: im
]

{ #category : #'*Toplo-Widget-Button' }
ToDefaultTheme >> checkboxUncheckedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   margin: (BlInsets all: 0);
			   background: (anElement toTheme colorBgContainer alpha: 0);
			   yourself)
]
