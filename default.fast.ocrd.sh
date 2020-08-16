#!/usr/bin/env ocrd-wf

olena-binarize -I OCR-D-IMG -O OCR-D-BIN -P impl sauvola
anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP
olena-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P impl kim
cis-ocropy-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page
tesserocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P operation_level page
tesserocr-segment-region -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG-REG
segment-repair -I OCR-D-SEG-REG -O OCR-D-SEG-REPAIR -P plausibilize true
cis-ocropy-deskew -I OCR-D-SEG-REPAIR -O OCR-D-SEG-REG-DESKEW -P level-of-operation region
cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP -P level-of-operation region
tesserocr-segment-line -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE
segment-repair -I OCR-D-SEG-LINE -O OCR-D-SEG-REPAIR-LINE -P sanitize true
cis-ocropy-dewarp -I OCR-D-SEG-REPAIR-LINE -O OCR-D-SEG-LINE-RESEG-DEWARP
calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P checkpoint '/path/to/models/\*.ckpt.json'
