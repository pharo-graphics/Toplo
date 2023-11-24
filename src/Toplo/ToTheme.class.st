Class {
	#name : 'ToTheme',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'cleanup' }
ToTheme class >> cleanUp [
	<script>

	current := nil
]

{ #category : 'cleanup' }
ToTheme class >> cleanUp: anObject [

	self cleanUp
]

{ #category : 'current' }
ToTheme class >> current [

	^ current ifNil: [ current := ToRawTheme new ]
]

{ #category : 'accessing' }
ToTheme class >> defaultCheckboxBlankImage [

	| bar im |
	bar := ToElement new id: #bar.
	bar withoutSkin.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := ToElement new.
	im layout: BlFrameLayout new.
	im size: 16 asPoint.
	im addChild: bar.
	im withoutSkin.
	bar withAllStamps: #( #bar ).
	im withAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : 'accessing' }
ToTheme class >> defaultColorPrimary [

	^ Color blue
]

{ #category : 'accessing' }
ToTheme class >> defaultTokenPropertyList [
	" skin managing need a list of unique stamps . "


	^ {
		  (ToTokenProperty name: #'background-color' value: Color white).

		  (ToTokenProperty name: #'border-radius' value: 6).
		  (ToTokenProperty name: #'border-radius-LG' value: 8).
		  (ToTokenProperty name: #'border-radius-SM' value: 4).
		  (ToTokenProperty
			   name: #'checkbox-image-builder'
			   value: [ self defaultCheckboxBlankImage ]).

		  (ToTokenProperty
			   name: #'color-bg-container'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-bg-container-disabled'
			   value: (Color black alpha: 0.04)).
		  (ToTokenProperty
			   name: #'color-bg-text-active'
			   value: (Color black alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-hover'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border'
			   value: (Color fromHexString: '#d9d9d9')).
		  (ToTokenProperty
			   name: #'color-border-checkable'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'color-border-disabled'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-error-bg'
			   value: (Color fromHexString: '#fff2f0')).
		  (ToTokenProperty
			   name: #'color-error-hover'
			   value: (Color fromHexString: '#ff7875')).
		  (ToTokenProperty
			   name: #'color-error-pressed'
			   value: (Color fromHexString: '#e75c5d')).
		  (ToTokenProperty
			   name: #'color-error'
			   value: (Color fromHexString: '#ff4d4f')).
		  (ToTokenProperty
			   name: #'color-image-disabled'
			   value: (Color black alpha: 1.0)).
		  (ToTokenProperty
			   name: #'color-image-light-solid'
			   value: (Color fromHexString: '#ffffff')).

		  (ToTokenProperty
			   name: #'color-link'
			   value: (Color fromHexString: '#1677ff')).
		  (ToTokenProperty
			   name: #'color-link-active'
			   value: (Color fromHexString: '#0958d9')).
		  (ToTokenProperty
			   name: #'color-link-hover'
			   value: (Color fromHexString: '#69b1ff')).

		  (ToTokenProperty
			   name: #'color-primary'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'color-primary-pressed'
			   value: self defaultColorPrimary darker darker).
		  (ToTokenProperty
			   name: #'color-primary-hover'
			   value: self defaultColorPrimary lighter lighter).

		  (ToTokenProperty
			   name: #'color-success'
			   value: (Color fromHexString: '#52c41a')).
		  (ToTokenProperty
			   name: #'color-warning'
			   value: (Color fromHexString: '#faad14')).

		  (ToTokenProperty name: #'color-text' value: Color black).
		  (ToTokenProperty
			   name: #'color-text-description'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'color-text-disabled'
			   value: (Color black alpha: 0.25)).
		  (ToTokenProperty
			   name: #'color-text-heading'
			   value: (Color black alpha: 0.88)).
		  (ToTokenProperty
			   name: #'color-text-light-solid'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-text-secondary'
			   value: (Color black alpha: 0.45)).

		  (ToTokenProperty name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToTokenProperty
			   name: #'font-family-code'
			   value: 'SFMono-Regular').
		  (ToTokenProperty name: #'font-size' value: 14).
		  (ToTokenProperty name: #'font-size-H1' value: 38).
		  (ToTokenProperty name: #'font-size-H2' value: 30).
		  (ToTokenProperty name: #'font-size-H3' value: 24).
		  (ToTokenProperty name: #'font-size-H4' value: 20).
		  (ToTokenProperty name: #'font-size-H5' value: 16).
		  (ToTokenProperty name: #'font-weight-strong' value: 600).

		  (ToTokenProperty name: #'line-height' value: 1.5).
		  (ToTokenProperty name: #'line-height-H1' value: 1.2).
		  (ToTokenProperty name: #'line-height-H2' value: 1.3).
		  (ToTokenProperty name: #'line-height-H3' value: 1.3).
		  (ToTokenProperty name: #'line-height-H4' value: 1.4).
		  (ToTokenProperty name: #'line-height-H5' value: 1.5).

		  (ToTokenProperty name: #'line-type' value: #solid).
		  (ToTokenProperty name: #'line-width' value: 1).
		  (ToTokenProperty name: #'line-width-focus' value: 4).

		  "Size, margin and padding"
		  (ToTokenProperty name: #'control-height' value: 32).
		  (ToTokenProperty name: #'control-height-LG' value: 40).
		  (ToTokenProperty name: #'control-height-SM' value: 24).

		  (ToTokenProperty name: #'margin-XS' value: 8).

		  (ToTokenProperty name: #'padding-content-H' value: 15).
		  (ToTokenProperty name: #'padding-content-V' value: 4).
		  (ToTokenProperty name: #'padding-XS' value: 8) }
]

{ #category : 'initialization' }
ToTheme >> defaultTokenPropertyList [
	^ self class defaultTokenPropertyList
]

{ #category : 'accessing' }
ToTheme >> name [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToTheme >> newSkinFor: anElement [

	anElement setUpForTheme: self.
	^ self newSkinInstanceFor: anElement
]

{ #category : 'accessing' }
ToTheme >> newSkinInstanceFor: anElement [

	^ self subclassResponsibility 
]

{ #category : 'styling' }
ToTheme >> newStyleSheet [ 

	^ nil
]

{ #category : 'printing' }
ToTheme >> printOn: aStream [

	aStream nextPutAll: '[Theme named: '; nextPutAll: self name; nextPutAll: ' ]'.
	super printOn: aStream
]

{ #category : 'hook' }
ToTheme >> setUpElementForTheme: anElement [
]
